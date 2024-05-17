import Flutter
import UIKit

public class PaystackFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.paystack.flutter", binaryMessenger: registrar.messenger())
    let instance = PaystackFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as? [String: Any]
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "build":
      initializeSDK(publicKey: "something", logging: true)
      result("Setup implementation in progress...")
    case "launch":
        print("Calling Launch SDK")
        result(arguments?["accessCode"] as? String)
//        result("Launch implementation in progress...")
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func initializeSDK(publicKey: String, logging: Bool) {
    // paystack = try? PaystackBuilder.newInstance.setKey(publicKey)

  }
}
