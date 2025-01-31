import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'paystack_flutter_platform_interface.dart';

// TODO: Handle responses
class MethodChannelPaystackFlutter extends PaystackFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('com.paystack.flutter');

  @override
  Future<String?> initialize(String publicKey, bool enableLogging) async {
    final response = await methodChannel.invokeMethod<String>('initialize', 
    {'publicKey': publicKey, 'enableLogging': enableLogging});

    return response;
  }

  @override
  Future<String?> launch(String accessCode) async {
    final response = await methodChannel.invokeMethod<String>('launch', 
      {'accessCode': accessCode});

    return response;
  }
}
