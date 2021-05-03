+++
title = "Adding Login"
date = 2020-04-15T14:32:10+01:00
weight = 33
chapter = false
pre = "<b> </b>"
+++

We've implemented the sign up portion of our auth flow, but now we need to update the login part. Update loginWithCredentials to this:

``` dart
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
``` dart
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

``` dart
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

Finally, we are calling showLogin inside of the initState method of _MyAppState. In **main.dart** let's change that to checkAuthStatus:

``` dart
... // _configureAmplify(); (line 26)
_authService.checkAuthStatus();
... // initState closing }
```

Those are the only modifications needed to compliment our existing authentication flow. Build and run the app and you should be able to sign up, confirm your email, sign out, then sign in again.

**Congratulations, you're now ready to commence Module 4!**