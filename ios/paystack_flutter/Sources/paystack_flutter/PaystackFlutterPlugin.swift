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
        self.result = result
        switch call.method {
        case "initialize":
            guard let args = call.arguments as? [String: Any],
                let publicKey = args["publicKey"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                    message: "Missing public key",
                                    details: nil))
                return
            }
            let logging = args["enableLogging"] as? Bool ?? false
            initialize(publicKey: publicKey, logging: logging)
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

    private func initialize(publicKey: String, logging: Bool) {
        do {
            let instance = PaystackBuilder
                .newInstance
                .setKey(publicKey)

            if logging {
                instance.enableLogging()
            }
            
            paystack = try instance.build()
            self.result?(true)
        } catch {
            self.result?(FlutterError(code: "INITIALIZATION_ERROR",
                                 message: error.localizedDescription,
                                 details: nil))
        }
    }
    
    private func launch(accessCode: String) {
        guard let paystack = paystack else {
            self.result?(FlutterError(code: "NOT_INITIALIZED",
                                 message: "Paystack not initialized",
                                details: nil))
            return
        }
        
        guard #available(iOS 14.0, *) else {
            self.result?(FlutterError(code: "UNSUPPORTED_VERSION",
                                 message: "Paystack UI requires iOS 14.0 or later",
                                details: nil))
            return
        }
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            self.result?(FlutterError(code: "NO_VIEW_CONTROLLER",
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
    
    private func paymentDone(_ transactionResult: TransactionResult) {
       switch (transactionResult) {
         case .completed(let details):
           self.result?([
                "status": true,
                "message": "Transaction successful",
                "reference": details.reference
           ])
         case .cancelled:
           self.result?([
                "status": false,
                "message": "Transaction cancelled",
                "reference": ""
           ])
         case .error(error: let error, reference: let reference):
           self.result?([
                "status": false,
                "message": error.message,
                "reference": ""
           ])
       }
     }
}
