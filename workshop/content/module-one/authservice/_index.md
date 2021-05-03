+++
title = "Creating an Auth Service"
date = 2020-04-15T14:32:10+01:00
weight = 14
chapter = false
pre = "<b> </b>"
+++

### Create an Auth service

If we want to display different pages, we will have to implement logic inside of our list to determine when to display specific pages. We can accomplish these updates by creating a Stream and nesting our Navigator in a StreamBuilder.

Create a new file called **auth_service.dart** and add the following:
``` dart
import 'dart:async';

// 1
enum AuthFlowStatus { login, signUp, verification, session }

// 2
class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

// 3
class AuthService {
  // 4
  final authStateController = StreamController<AuthState>();

  // 5
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  // 6
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}
```
1. AuthFlowStatus is an enumeration that will cover the four different states our auth flow can be in: the login page, sign up page, verification page, or a session. We will be adding the last two pages shortly.
2. AuthState is the actual object we will be observing in our stream and it will contain authFlowStatus as a property.
3. Our AuthService will serve two purposes, manage the stream controller of AuthState as well as contain all of our authentication functionality that will be added in the next module.
4. authStateController is responsible for sending new AuthState's down stream to be observed.
5. This is a simple function to update the AuthState stream to signUp.
6. This does the same as showSignUp but updates the stream to send login.

Open **main.dart** again and add create an instance of AuthService in _MyAppState.

``` dart
... // class _MyAppState extends State<MyApp> { (line 15)

final _authService = AuthService();

... // @override
```

AuthService needs to be imported to **main.dart**
``` dart
... // import 'sign_up_page.dart'; (line 3)
import 'auth_service.dart';

```
