import 'paystack_flutter_platform_interface.dart';

class PaymentSheet {
  Future<String?> launch(String accessCode) {
    return PaystackFlutterPlatform.instance.launch(accessCode);
  }
}
