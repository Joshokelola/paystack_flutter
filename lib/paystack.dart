import 'package:flutter/foundation.dart';

import 'paystack_flutter_platform_interface.dart';

class Paystack {
  String _publicKey = "";
  bool _logging = false;

  Paystack setPublicKey(String publicKey) {
    _publicKey = publicKey;
    return this;
  }

  Paystack enableLogging(bool logging) {
    _logging = logging;
    return this;
  }

  Paystack build() {
    _buildInternal(_publicKey, _logging);
    return this;
  }

  @protected
  Future<String?> _buildInternal(String publicKey, bool enableLogging) {
    return PaystackFlutterPlatform.instance.build(publicKey, enableLogging);
  }
}
