import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'paystack_flutter_method_channel.dart';
import 'models.dart';

abstract class PaystackFlutterPlatform extends PlatformInterface {
  PaystackFlutterPlatform() : super(token: _token);

  static final Object _token = Object();
  static PaystackFlutterPlatform _instance = MethodChannelPaystackFlutter();
  static PaystackFlutterPlatform get instance => _instance;

  static set instance(PaystackFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> initialize(String publicKey, bool enableLogging) {
    throw UnimplementedError('build() has not been implemented');
  }

  Future<TransactionResponse> launch(String accessCode) {
    throw UnimplementedError('launch() has not been implemented');
  }
}
