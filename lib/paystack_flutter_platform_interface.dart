import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'paystack_flutter_method_channel.dart';

abstract class PaystackFlutterPlatform extends PlatformInterface {
  /// Constructs a PaystackFlutterPlatform.
  PaystackFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PaystackFlutterPlatform _instance = MethodChannelPaystackFlutter();

  /// The default instance of [PaystackFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPaystackFlutter].
  static PaystackFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PaystackFlutterPlatform] when
  /// they register themselves.
  static set instance(PaystackFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
