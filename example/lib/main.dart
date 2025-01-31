import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:paystack_flutter/paystack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = "Unknown";
  String _paymentReference = "";
  String _publicKey = "pk_test_xxxxxx";
  String _accessCode = "fhnvmojgrpcdp98";
  final _paystack = Paystack();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    initialize(_publicKey);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion = await _paystack.getPlatformVersion() ??
  //         'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  Future<void> initialize(String publicKey) async {
    String response;
    try {
      response = await _paystack.initialize(publicKey, true) ??
          "Cannot init";
    } on PlatformException {
      response = 'Failed to set up SDK.';
    }

    print(response);
  }

  Future<void> launch() async {
    String response;
    try {
      response = await _paystack.launch(_accessCode) 
        ?? "Cannot launch";
    } on PlatformException {
      response = 'Failed to launch SDK.';
    }

    print(response);
    
    setState(() {
      _paymentReference = response;
    });
  }

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
                  onPressed: launch,
                  child: const Text('Make Payment')),
            ],
          )),
    );
  }
}
