import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

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
  String _paymentReference = "";
  final _publicKey = "pk_test_xxxxxx";
  final _accessCode = "2g3pyob7ey9dbtj";
  final _paystack = Paystack();

  @override
  void initState() {
    super.initState();
    initialize(_publicKey);
  }

  Future<void> initialize(String publicKey) async {
    try {
      final response = await _paystack.initialize(publicKey, true);
      log(response as String);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> launch() async {
    String reference = "";
    try {
      final response = await _paystack.launch(_accessCode);
      if (response.status) {
        reference = response.reference;
        print(reference);
        // _displayToast(context, reference);
      } else {
        print(response.message);
      }
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _paymentReference = reference;
    });
  }

  void _displayToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(label: "SDK", onPressed: scaffold.hideCurrentSnackBar),
      )
    );
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
                  onPressed: launch, child: const Text('Make Payment')),
            ],
          )),
    );
  }
}
