# Module 3

## Introduction
The first Amplify category you will be adding to the app will be Authentication. Amplify leverages Amazon Cognito under the hood for managing user pools and identity pools.

In this module you will learn how to sign up, confirm, login, and sign out a user. We will be implementing the functionality for each screen in just a few lines of code.

## What You Will Learn
* Configure the Auth category
* Sign up a user
* Verify a user email
* Login an authenticated user
* Sign out an authenticated user

## Key Concepts
Authentication - Authentication is the process of verifying and managing a user, allowing them to interact with resources of the app.

## Implementation

### Add dependencies to Flutter
The next step is to install Amplify as a dependency in our project so we can interface with the libraries.

Back in Visual Studio Code, open **pubspec.yaml** and add the following dependency:
``` javascript
... // dependencies: (line 23)

  amplify_core: '<1.0.0'
  amplify_flutter: '<1.0.0'
  amplify_auth_cognito: '<1.0.0'
  amplify_analytics_pinpoint: '<1.0.0'

... // flutter
```
### Configuring Flutter to integrate with Amplify
We'll start by importing the dependencies into **main.dart**
``` javascript
... // import 'app_flow.dart'; (line 6)

import 'package:amplify_flutter/amplify.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

... // void main() {
```

``` javascript
.. // }  Widget build closing brace (line 81)
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

``` javascript
... // super.initState(); (line 25)
    _configureAmplify();
... // _authService.showLogin();
```

Back in the Create A Flutter App module, we implemented our AuthService to handle the updating of our AuthState based on the function called. Now we need to update each of our functions to only update the state when the user successfully completes each process.

In **auth_service.dart** add an AuthCredentials property in AuthService:

``` javascript
... // import 'auth_credentials.dart'; (line 2)
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
```

``` javascript
.. // final authStateController = StreamController<AuthState>(); (line 17)
AuthCredentials _credentials;
... // void showSignUp() {
```

This property will be used to keep the SignUpCredentials in memory during the sign up process so a user can be logged in immediately after verifying their email address. If we didn't do this, the user would need to login manually by going to the login screen.

Update signUpWithCredentials to the following:

``` javascript
  ... // } Closing brace of loginWithCredentials (line 34)

// 1
void signUpWithCredentials(SignUpCredentials credentials) async {
  try {
    // 2
    final userAttributes = {'email': credentials.email};

    // 3
    final result = await Amplify.Auth.signUp(
        username: credentials.username,
        password: credentials.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes));

    // 4
    if (result.isSignUpComplete) {
      loginWithCredentials(credentials);
    } else {
      // 5
      this._credentials = credentials;

      // 6
      final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
      authStateController.add(state);
    }
  // 7
    } on AmplifyException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
}
```

1. The function needs to be updated to be async as we will be using await to during the sign up process.
2. We must create userAttributes to pass in the user's email as part of the sign up.
3. We will pass in the username and password provided by the credentials, along with the user attributes containing the email to sign up with Cognito. Since this is an asynchronous process, we must use the await keyword.
4. If we successfully get a result back, the next step should be to verify their email. If the sign up process is complete for whatever reason, we will simply login the user to the app.
5. We will store the SignUpCredentials in _credentials for when the user verifies their email.
6. We update the AuthState to verification just as we did before, but only after successfully signing in and establishing that the sign up process is not complete.
7. If the sign up fails for any reason, we will simply print out the error to the logs.

Update verifyCode to this:

``` javascript
 ... // } Closing brace of signUpWithCredentials (line 68)

// 1
void verifyCode(String verificationCode) async {
 try {
   // 2
   final result = await Amplify.Auth.confirmSignUp(
       username: _credentials.username, confirmationCode: verificationCode);

   // 3
   if (result.isSignUpComplete) {
     loginWithCredentials(_credentials);
   } else {
     // 4
     // Follow more steps
   }
   } on AmplifyException catch (authError) {
     print('Failed to sign up - ${authError.message}');
   }
}
```
1. Just like we did with signUpWithCredentials, verifyCode needs to be marked as an asynchrous function as well.
2. We will use _credentials to supply the username and pass the code entered from VerificationPage to confirmSignUp.
3. If the result from confirmSignUp specifies that the sign up is complete, we then attempt to login the user with _credentials created during sign up. It's important to note that we are no longer updating the AppState during the success case as the user still needs to login to Amplify.
4. If the sign up in not complete, then use the result to find out what further steps need to be taken to complete the sign up. This should not happen in our app.

We've implemented the sign up portion of our auth flow, but now we need to update the login part. Update loginWithCredentials to this:

``` javascript
 ... // } Closing brace of show login (line 31)
// 1
void loginWithCredentials(AuthCredentials credentials) async {
 try {
   // 2
   final result = await Amplify.Auth.signIn(
       username: credentials.username, password: credentials.password);

   // 3
   if (result.isSignedIn) {
     final state = AuthState(authFlowStatus: AuthFlowStatus.session);
     authStateController.add(state);
   } else {
     // 4
     print('User could not be signed in');
   }
   } on AmplifyException catch (authError) {
     print('Failed to sign up - ${authError.message}');
   }
}
```

1. Since loginWithCredentials takes AuthCredentials as a parameter, it will work whether it is passed LoginCredentials or SignUpCredentials.
2. We're passing the AuthCredentials username and password to the Amplify sign in method and awaiting the result.
3. If the sign in is successful and the isSignedIn property on the result confirms the user is now signed in, we update the state to session.
4. We should not reach this state in our app. If the user enters in the wrong credentials or gets any other error, it should result in our catch block.

Now, update the logOut method:
``` javascript
 ... // } Closing brace of verifyCode (line 102)

void logOut() async {
 try {
   // 1
   await Amplify.Auth.signOut();

   // 2
   showLogin();
   } on AmplifyException catch (authError) {
    print('Failed to sign up - ${authError.message}');
   }
}
```

1. When we call Auth.signOut() without passing in any options, we will sign out only the user on this device as opposed to signing the user out on all devices.
2. We can reuse our showLogin() method to update the state and take the user back to the login screen once the sign out is successful.

Lastly, we need to be able to automatically log the user in if they close the app but have already logged in during a previous session. Add this final function to AuthService.

``` javascript
 ... // } Closing brace of logOut (line 114)
void checkAuthStatus() async {
 try {
   await Amplify.Auth.fetchAuthSession();

   final state = AuthState(authFlowStatus: AuthFlowStatus.session);
   authStateController.add(state);
 } catch (_) {
   final state = AuthState(authFlowStatus: AuthFlowStatus.login);
   authStateController.add(state);
 }
}
```

checkAuthStatus will attempt to get the current AuthSession; if it's successful, the user will be signed in. If the fetch fails, this means the user is not logged in and should be presented with LoginPage.

At the moment, we are calling showLogin inside of the initState method of _MyAppState. Let's change that to checkAuthStatus:

``` javascript
... // _configureAmplify(); (line 26)
_authService.checkAuthStatus();
... // initState closing }
```

Those are the only modifications needed to compliment our existing authentication flow. Build and run the app and you should be able to sign up, confirm your email, sign out, then sign in again.


[<- Lab 2](../lab2/README.md) || [Lab 4 ->](../lab4/README.md) 