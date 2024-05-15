
import 'paystack_flutter_platform_interface.dart';

class PaystackFlutter {
  Future<String?> getPlatformVersion() {
    return PaystackFlutterPlatform.instance.getPlatformVersion();
  }
}
