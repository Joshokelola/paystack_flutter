import 'paystack_platform_interface.dart';
import 'models.dart';

class Paystack {
  Future<bool> initialize(String publicKey, bool enableLogging) {
    return PaystackSDKPlatform.instance
        .initialize(publicKey, enableLogging);
  }

  Future<TransactionResponse> launch(String accessCode) {
    return PaystackSDKPlatform.instance.launch(accessCode);
  }
}