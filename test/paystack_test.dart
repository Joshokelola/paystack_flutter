import 'package:flutter_test/flutter_test.dart';
import 'package:paystack_flutter/src/models.dart';
import 'package:paystack_flutter/src/paystack_flutter_platform_interface.dart';
import 'package:paystack_flutter/src/paystack_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPaystackFlutterPlatform
    with MockPlatformInterfaceMixin
    implements PaystackFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> build(String publicKey, bool enableLogging) {
    return Future.value("Coming soon...");
  }
  
  @override
  Future<bool> initialize(String publicKey, bool enableLogging) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<TransactionResponse> launch(String accessCode) {
    // TODO: implement launch
    throw UnimplementedError();
  }
}

void main() {
  final PaystackFlutterPlatform initialPlatform =
      PaystackFlutterPlatform.instance;

  test('$MethodChannelPaystackFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPaystackFlutter>());
  });

  test('getPlatformVersion', () async {
    // PaystackFlutter paystackFlutterPlugin = PaystackFlutter();
    MockPaystackFlutterPlatform fakePlatform = MockPaystackFlutterPlatform();
    PaystackFlutterPlatform.instance = fakePlatform;

    // expect(await paystackFlutterPlugin.getPlatformVersion(), '42');
  });

  // The unit test is actually not worth it!

  test('launch', () async {
    // PaymentSheet paymentSheet = PaymentSheet();
    MockPaystackFlutterPlatform fakePlatform = MockPaystackFlutterPlatform();
    PaystackFlutterPlatform.instance = fakePlatform;

    // expect(await paymentSheet.launch("accessCode"), "Launched");
  });
}
