# Paystack Flutter SDK

A [Paystack](https://paystack.com) plugin for accepting payments in your Flutter application.

## Support 
| Android |   iOS   |  MacOS  |   Web   |  Linux  | Windows |
|  :---:  |  :---:  |  :---:  |  :---:  |  :---:  |  :---:  |
| &check; | &check; | &cross; | &cross; | &cross; | &cross; |

## Requirements
Paystack Flutter SDK builds upon the recent patterns in the Android and iOS, thus your app should target:
- Flutter >= 3.3.0
- iOS >= 13
- Android 
  - Minimum SDK: 23
  - Compile SDK: 34

> [!IMPORTANT]
>
> Flutter (3.3.0 below, at the moment) extends the `FlutterActivity` as the base class for Android. The `FlutterActivity` doesn't have the `ComponentActivity`, a compulsory necessity for loading the payment views with the SDK, in its ancestral tree. To fix this, change the `FlutterActivity` to `FlutterFragmentActivity` in the `MainActivity` in the `android` folder of your project.

## Getting Started
- Install the dependency in your project
```sh
flutter pub get link_coming_soon
```
- Import the paystack_flutter into your `.dart` file
```dart
import 'package:paystack_flutter/paystack.dart';
```
- Use the plugin
```dart
final _publicKey = "pk_domain_xxxxxx";
final _accessCode = "67joTry7t1jz2o";
final _paystack = Paystack();

 initialize(String publicKey) async {
    try {
      final response = await _paystack.initialize(publicKey, true);
      if (response) {
        log("Sucessfully initialised the SDK");
      } else {
        log("Unable to initialise the SDK");
      }
    } on PlatformException catch (e) {
      log(e.message!);
    }
  }

  launch() async {
    String reference = "";
    try {
      final response = await _paystack.launch(_accessCode);
      if (response.status) {
        reference = response.reference;
        log(reference);
      } else {
        log(response.message);
      }
    } on PlatformException catch (e) {
      log(e.message!);
    }

    setState(() {
      _reference = reference;
    });
  }
```


