import Flutter
import UIKit
import PaystackCore
import PaystackUI

public class PaystackFlutterPlugin: NSObject, FlutterPlugin {
    private var paystack: Paystack?
    private var result: FlutterResult?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.paystack.flutter", binaryMessenger: registrar.messenger())
        let instance = PaystackFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            guard let args = call.arguments as? [String: Any],
                let publicKey = args["publicKey"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                    message: "Missing public key",
                                    details: nil))
                return
            }
            initialize(publicKey: publicKey)
        case "launch":
            guard let args = call.arguments as? [String: Any],
                let accessCode = args["accessCode"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                    message: "Missing access code",
                                    details: nil))
                return
            }
            launch(accessCode: accessCode)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func initialize(publicKey: String) {
        do {
            paystack = try PaystackBuilder
                .newInstance
                .setKey(publicKey)
                .build()
            result?("true")
        } catch {
            result?(FlutterError(code: "INITIALIZATION_ERROR",
                                 message: error.localizedDescription,
                                 details: nil))
        }
    }
    
    private func launch(accessCode: String) {
        guard let paystack = paystack else {
            result?(FlutterError(code: "NOT_INITIALIZED",
                                 message: "Paystack not initialized",
                                details: nil))
            return
        }
        
        guard #available(iOS 14.0, *) else {
            result?(FlutterError(code: "UNSUPPORTED_VERSION",
                                 message: "Paystack UI requires iOS 14.0 or later",
                                details: nil))
            return
        }
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            result?(FlutterError(code: "NO_VIEW_CONTROLLER",
                                 message: "Unable to present payment UI",
                                details: nil))
            return
        }
        
        paystack.presentChargeUI(
            on: viewController,
            accessCode: accessCode,
            onComplete: { [weak self] transactionResult in
                self?.paymentDone(transactionResult)
        })
    }
    
    private func paymentDone(_ result: TransactionResult) {
       switch (result) {
         case .completed(let details):
           self.result?([
                "status": "success",
                "reference": details.reference
           ])
         case .cancelled:
           self.result?([
                "status": "cancelled"
           ])
         case .error(error: let error, reference: let reference):
           self.result?(FlutterError(code: "TRANSACTION_ERROR",
                                     message: error.message,
                                     details: ["reference": reference ?? ""]))
       }
     }
}
