import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:paystack_flutter/paystack_flutter.dart';
import 'package:paystack_flutter/paystack.dart';
import 'package:paystack_flutter/payment_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _paymentSheet = PaymentSheet();
  final _paystackFlutterPlugin = PaystackFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();

    Paystack()
      // .setPublicKey("pk_test_xxxx")
      .enableLogging(true)
      .build();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _paystackFlutterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> launchPaystack() async {
    String response;
    try {
      response =
          await _paymentSheet.launch("access_codes") ?? "Cannot launch";
    } on PlatformException {
      response = 'Failed to launch SDK.';
    }

    print(response);
  }

  // void _triggerMethodChannel() {
  //   launchPaystack();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Paystack Flutter'),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: launchPaystack,
                  child: const Text('Make Payment')),
              const SizedBox(width: 16),
              Text('Running on: $_platformVersion\n'),
            ],
          )),
    );
  }
}
