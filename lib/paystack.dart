import 'paystack_flutter_platform_interface.dart';
import 'models.dart';


class Paystack {
  Future<bool> initialize(String publicKey, bool enableLogging) {
    return PaystackFlutterPlatform.instance
        .initialize(publicKey, enableLogging);
  }

  Future<TransactionResponse> launch(String accessCode) {
    return PaystackFlutterPlatform.instance.launch(accessCode);
  }
}
