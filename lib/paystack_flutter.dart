import 'paystack_flutter_platform_interface.dart';

// TODO: Delete file after iOS integration
class PaystackFlutter {
  Future<String?> getPlatformVersion() {
    return PaystackFlutterPlatform.instance.getPlatformVersion();
  }

  // Future<String?> build(String publicKey, bool enableLogging) {
  //   return PaystackFlutterPlatform.instance.build(publicKey, enableLogging);
  // }

  // Future<String?> launch(String accessCode) {
  //   return PaystackFlutterPlatform.instance.launch(accessCode);
  // }
}
