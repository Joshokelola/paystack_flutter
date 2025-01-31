import 'paystack_flutter_platform_interface.dart';

// TODO: Handle responses
// TODO: Consider exposing with builder pattern
class Paystack {

  Future<String?> initialize(String publicKey, bool enableLogging) {
    return PaystackFlutterPlatform.instance.initialize(publicKey, enableLogging);
  }

  Future<String?> launch(String accessCode) {
    return PaystackFlutterPlatform.instance.launch(accessCode);
  }
}
