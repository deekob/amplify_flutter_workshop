+++
title = "Implementing Navigation"
date = 2020-04-15T14:32:10+01:00
weight = 15
chapter = false
pre = "<b> </b>"
+++

### Lets fix up Navigation

Now we can wrap the Navigator in a StreamBuilder.

``` dart
... // theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity), (line 22)

// 1
home: StreamBuilder<AuthState>(
    // 2
    stream: _authService.authStateController.stream,
    builder: (context, snapshot) {
      // 3
      if (snapshot.hasData) {
        return Navigator(
          pages: [
            // 4
            // Show Login Page
            if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
              MaterialPage(child: LoginPage()),

            // 5
            // Show Sign Up Page
            if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
              MaterialPage(child: SignUpPage())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      } else {
        // 6
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
    }),
    
... // MaterialApp closing ); (line 30)
```
1. We wrapped our Navigator with a StreamBuilder that is expecting to observe a stream emitting AuthState.
2. We access the AuthState stream by accessing it from the authStateController from the instance of AuthService.
3. The stream may or may not have data. In order to safely access authFlowStatus from our data, which is of type AuthState, we implement the check here first.
4. If the stream emits AuthFlowStatus.login we will show LoginPage.
5. If the stream emits AuthFlowStatus.signUp we will show SignUpPage.
6. If the stream doesn't have data, a CircularProgressIndicator is displayed.
To ensure stream has data from the start, a value needs to be emitted immediately. We can accomplish this by sending AuthFlowStatus.login when _MyAppState is initialized.

``` dart
... // final _authService = AuthService(); (line 17)

@override
void initState() {
 super.initState();
 _authService.showLogin();
}

... // @override
```

If we run the app now, it should be displaying LoginPage as that's the only value that has been emitted through the stream.

We still need to implement the ability to switch between LoginPage and SignUpPage.

Navigate to **login_page.dart** and add the following:
``` dart
... // class LoginPage extends StatefulWidget { (line 3)

final VoidCallback shouldShowSignUp;

LoginPage({Key key, this.shouldShowSignUp}) : super(key: key);

... // @override (line 4)
```
Our constructor is now accepting a VoidCallback as an arguement which can trigger some functionality in main.dart and called from _LoginPageState.

Pass shouldShowSignUp as the argument for the sign up button in our _LoginPageState:

``` dart
... // child: FlatButton( (line 32)

onPressed: widget.shouldShowSignUp,

... // child: Text('Don\'t have an account? Sign up.')), (line 34)
```
Back in **main.dart** we need to pass an arguement for the shouldShowSignUp parameter of the LoginPage:
``` dart
... // if (snapshot.data.authFlowStatus == AuthFlowStatus.login) (line 40)

MaterialPage(
   child: LoginPage(
       shouldShowSignUp: _authService.showSignUp)),

... // Show Sign Up Page
```
Run the app and press the sign up button on LoginPage. It should now navigate to SignUpPage

We need to be able to do the same thing for SignUpPage so the user can switch between sign up and login by tapping the button at the bottom of the screen.

Add the following to **sign_up_page.dart**:

``` dart
... // class SignUpPage extends StatefulWidget { (line 3)

final VoidCallback shouldShowLogin;

SignUpPage({Key key, this.shouldShowLogin}) : super(key: key);

... // @override
```
``` dart
... // child: FlatButton( (line 27)

onPressed: widget.shouldShowLogin,

... // child: Text('Already have an account? Login.')),
```

Just as we implemented with LoginPage, SignUpPage will trigger the VoidCallback when the user presses the botton at the bottom of the screen.

Now to simply update **main.dart** to accept an arguement for shouldShowLogin.
``` dart
... // if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp) (line 46)

MaterialPage(
   child: SignUpPage(
       shouldShowLogin: _authService.showLogin))

... // pages closing ],
```
If you run the app this time, you'll notice you're able to toggle between the LoginPage and SignUpPage.