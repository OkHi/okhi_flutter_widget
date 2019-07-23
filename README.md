# OkHi Flutter Widget

This Widget provides you with a quick and easy way to start collecting high accuracy location information from your users.

## Requirements
- An OkHi API Key. Get one [here](https://www.okhi.com/business)

## Usage
To use this plugin, add `okhi_flutter_widget` as a dependency in your pubspec.yaml file.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:okhi_flutter_widget/okhi_flutter_widget.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // make sure to have an apiKey before hand
    OkHiAuth auth = OkHiAuth(
      apiKey: "<< my-okhi-api-key >>"
    );

    // only phone is required
    OkHiUser user = OkHiUser(
      phone: "+254712xxxxxx", 
      firstName: "John",
      lastName: "Doe"
    );

    return Scaffold(
      // add the below line to avoid keyboard padding issues
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('My App Bar'),
      ),
      body: OkHi(
        auth: auth,
        user: user,
        onSucess: (OkHiLocation location, OkHiUser user) {
          // handle success
        },
        onError: (error) {
          // handle errors
          print(error.message);
        },
        mode: OkHiLaunchMode.start_app,
      ),
    );
  }
}
```
