+++
title = "Adding SignUp"
date = 2020-04-15T14:32:10+01:00
weight = 32
chapter = false
pre = "<b> </b>"
+++

Back in the Create A Flutter App module, we implemented our AuthService to handle the updating of our AuthState based on the function called. Now we need to update each of our functions to only update the state when the user successfully completes each process.

In **auth_service.dart** add an AuthCredentials property in AuthService:

``` dart
... // import 'auth_credentials.dart'; (line 2)
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
```

``` dart
.. // final authStateController = StreamController<AuthState>(); (line 17)
AuthCredentials _credentials;
... // void showSignUp() {
```

This property will be used to keep the SignUpCredentials in memory during the sign up process so a user can be logged in immediately after verifying their email address. If we didn't do this, the user would need to login manually by going to the login screen.

Update signUpWithCredentials to the following:

``` dart
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

``` dart
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
