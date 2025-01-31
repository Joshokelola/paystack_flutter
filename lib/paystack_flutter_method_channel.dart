import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'paystack_flutter_platform_interface.dart';

class MethodChannelPaystackFlutter extends PaystackFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('com.paystack.flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> build(String publicKey, bool enableLogging) async {
    final response = await methodChannel.invokeMethod<String>(
        'build', {'publicKey': publicKey, 'enableLogging': enableLogging});

    return response;
  }

  @override
  Future<String?> launch(String accessCode) async {
    final response = await methodChannel
        .invokeMethod<String>('launch', {'accessCode': accessCode});

    return response;
  }
}
