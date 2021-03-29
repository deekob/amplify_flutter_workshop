+++
title = "Passing Credentials"
date = 2020-04-15T14:32:10+01:00
weight = 16
chapter = false
pre = "<b> </b>"
+++

### Credentials

The last thing needed for each of these pages is a way to pass the user input for each field as credentials that can be processed for login/sign up.

Create a new file called **auth_credentials.dart** and add the following:
``` dart
// 1
abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({this.username, this.password});
}

// 2
class LoginCredentials extends AuthCredentials {
  LoginCredentials({String username, String password})
      : super(username: username, password: password);
}

// 3
class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({String username, String password, this.email})
      : super(username: username, password: password);
}
```
1. AuthCredentials is an abstract class that we will use for a baseline of the minimum info needed to perform either login or sign up. This will allow us to use LoginCredentials and SignUpCredentials almost interchangeably.
2. LoginCredentials a simple concrete implementation of AuthCredentials as logging in only requires the username and password.
3. Almost exactly the same as the LoginCredentials but with email being an added field required for signing up.
We can now add login and sign up methods to AuthService which will accept the respective credentials and change the state of the Navigator to the correct page.

Add these two functions to **auth_service.dart**:
``` dart
... // showLogin closing } (line 28)

// 1
void loginWithCredentials(AuthCredentials credentials) {
 final state = AuthState(authFlowStatus: AuthFlowStatus.session);
 authStateController.add(state);
}

// 2
void signUpWithCredentials(SignUpCredentials credentials) {
 final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
 authStateController.add(state);
}
```

And  auth_credetials to **auth_service.dart**
``` dart
... // import 'dart:async'; (line 1)
import 'auth_credentials.dart';
... 
```

1. When a user passes any AuthCredentials we will perform some logic and ultimately put the user in a session state.
2. Signing up will require that the email entered is verified by entering a verification code. Thus, the sign up logic should chage the state to verification.

Let's start by updating **login_page.dart** to send LoginCredentials via a ValueChanged property.
 ``` dart
 ... // import 'package:flutter/material.dart'; (line 1)
 import 'auth_credentials.dart';

 ... // class LoginPage extends StatefulWidget { 

final ValueChanged<LoginCredentials> didProvideCredentials;

... // final VoidCallback shouldShowSignUp;

LoginPage({Key key, this.didProvideCredentials, this.shouldShowSignUp})
   : super(key: key);

... // @override
```
We can now pass our credentials from the _login() method in _LoginPageState:

``` dart
... // print('password: $password'); (line 80)

final credentials =
  LoginCredentials(username: username, password: password);
widget.didProvideCredentials(credentials);

... // _login closing }
```

Let's implement something similar for **sign_up_page.dart**:

``` dart
 ... // import 'package:flutter/material.dart'; (line 1)
 import 'auth_credentials.dart';

... // class SignUpPage extends StatefulWidget {

final ValueChanged<SignUpCredentials> didProvideCredentials;

... // final VoidCallback shouldShowLogin;

SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin})
   : super(key: key);

... // @override
```
And create the credentials:
``` dart
... // print('password: $password'); (line 81)

final credentials = SignUpCredentials(
   username: username, 
   email: email, 
   password: password
);
widget.didProvideCredentials(credentials);

... // _signUp closing }
```
Now connect everything in **main.dart**:
``` dart
... // child: LoginPage( (line 42)

didProvideCredentials: _authService.loginWithCredentials,

... // shouldShowSignUp: _authService.showSignUp)),
```

``` dart
... // child: SignUpPage( (line 50)

didProvideCredentials: _authService.signUpWithCredentials,

... // shouldShowLogin: _authService.showLogin))
```

That wraps up LoginPage and SignUpPage, but as we saw with AuthFlowStatus we still need to implement a page for verification and pages to represent a session.

Let's add VerificationPage in a new file **verification_page.dart**:
``` dart
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;

  VerificationPage({Key key, this.didProvideVerificationCode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _verificationForm(),
      ),
    );
  }

  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Verification Code TextField
        TextField(
          controller: _verificationCodeController,
          decoration: InputDecoration(
              icon: Icon(Icons.confirmation_number),
              labelText: 'Verification code'),
        ),

        // Verify Button
        FlatButton(
            onPressed: _verify,
            child: Text('Verify'),
            color: Theme.of(context).accentColor)
      ],
    );
  }

  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();
    widget.didProvideVerificationCode(verificationCode);
  }
}
```

The VerificationPage is really just a slimmed down version of LoginPage and only passes a verification code up the widget tree.

Back in **auth_service.dart**, there needs to be a method to handle the verification code and update the state to session.

``` dart
... // signUpWithCredentials closing } (line 41)

void verifyCode(String verificationCode) {
 final state = AuthState(authFlowStatus: AuthFlowStatus.session);
 authStateController.add(state);
}

... // AuthService closing }
```

Now add the VerificationPage to the Navigator of **main.dart**.
``` dart
... // import 'auth_service.dart'; (line 4)
import 'verification_page.dart';
```

``` dart
... // shouldShowLogin: _authService.showLogin)), (line 54)

// Show Verification Code Page
if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
  MaterialPage(child: VerificationPage(
    didProvideVerificationCode: _authService.verifyCode))

... // pages closing ],
```

For the moment, we're going to add a placeholder page that we will come back and add functionality to. Add **gps_page.dart** with the following content :
``` dart
import 'package:flutter/material.dart';

// 1
class GpsPage extends StatelessWidget {
  // 2
  final VoidCallback shouldLogOut;

  GpsPage({Key key, this.shouldLogOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Co-ordinates'),
        actions: [
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child:
                GestureDetector(child: Icon(Icons.logout), onTap: shouldLogOut),
          )
        ],
      ),
      // 5
      body: Container(),
    );
  }
}
```


To close the navigation loop of our UI, we need to add a log out method to **auth_service.dart**.
``` dart
... // verifyCode closing } (line 46)

void logOut() {
 final state = AuthState(authFlowStatus: AuthFlowStatus.login);
 authStateController.add(state);
}

... // AuthService closing }
```

Finally, implement the case for GpsPage in the Navigator.pages of **main.dart**.
``` dart
... // import 'verification_page.dart' (line 5)
import 'gps_page.dart';
```

``` dart
... // _authService.verifyCode)), (line 62)
if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
    MaterialPage(
        child: GpsPage(shouldLogOut: _authService.logOut))
... // pages closing ]                ],
```

### Test the application

The application should allow you to navigate between sign up, login and the placeholder GPS Page (which allows you to log out).

![GPS_screen](/images/GPS_screen.png)

**Congratulations, you're now ready to commence Module 2!**
