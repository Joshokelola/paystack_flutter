import 'package:flutter_test/flutter_test.dart';
import 'package:paystack_flutter/paystack_flutter.dart';
import 'package:paystack_flutter/paystack_flutter_platform_interface.dart';
import 'package:paystack_flutter/paystack_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPaystackFlutterPlatform
    with MockPlatformInterfaceMixin
    implements PaystackFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PaystackFlutterPlatform initialPlatform = PaystackFlutterPlatform.instance;

  test('$MethodChannelPaystackFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPaystackFlutter>());
  });

  test('getPlatformVersion', () async {
    PaystackFlutter paystackFlutterPlugin = PaystackFlutter();
    MockPaystackFlutterPlatform fakePlatform = MockPaystackFlutterPlatform();
    PaystackFlutterPlatform.instance = fakePlatform;

    expect(await paystackFlutterPlugin.getPlatformVersion(), '42');
  });
}
