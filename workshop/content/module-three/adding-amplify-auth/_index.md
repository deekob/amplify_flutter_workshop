+++
title = "Adding Amplify Auth"
date = 2020-04-15T14:32:10+01:00
weight = 31
chapter = false
pre = "<b> </b>"
+++

## Implementation

### Add dependencies to Flutter
The next step is to install Amplify as a dependency in our project so we can interface with the libraries.

Back in Visual Studio Code, open **pubspec.yaml** and add the following dependency:
``` dart
... // dependencies: (line 23)

  amplify_core: '<1.0.0'
  amplify_flutter: '<1.0.0'
  amplify_auth_cognito: '<1.0.0'
  amplify_analytics_pinpoint: '<1.0.0'

... // flutter
```
### Configuring Flutter to integrate with Amplify
We'll start by importing the dependencies into **main.dart**
``` dart
... // import 'gps_page.dart'; (line 6)

import 'package:amplify_flutter/amplify.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

... // void main() {
```

``` dart
.. // }  Widget build closing brace (line 92)
   void _configureAmplify() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin]);
    try {
      await Amplify.configure(amplifyconfig);
      print(' Successfully configured Amplify 🎉');
    } catch (e) {
      print(e);
      print(' Could not configure Amplify ☠️');
    }
  }
```

``` dart
... // super.initState(); (line 25)
    _configureAmplify();
... // _authService.showLogin();
```
