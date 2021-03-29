+++
title = "Creating a SignUp Widget"
date = 2020-04-15T14:32:10+01:00
weight = 13
chapter = false
pre = "<b> </b>"
+++

### Create a SignUp widget

The user will need to be able to sign up before they can sign in. Let's implement the SignUpPage in a new file **sign_up_page.dart**
``` dart
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: () {},
                  child: Text('Already have an account? Login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.person), labelText: 'Username'),
        ),

        // Email TextField
        TextField(
          controller: _emailController,
          decoration:
              InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // Sign Up Button
        FlatButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
            color: Theme.of(context).accentColor)
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');
  }
}
```
Our SignUpPage is almost identical to the LoginPage with the exception that it has an additional field for email and the text for the buttons have been changed.

Let's add the SignUpPage as a MaterialPage in the Navigator of **main.dart** too.
``` dart
... // home: Navigator( (line 20)

pages: [
  MaterialPage(child: LoginPage()),
  MaterialPage(child: SignUpPage())
],

... // onPopPage: (route, result) => route.didPop(result),
```

You'll see that there's no definition in scope for LoginPage() and SingupPage(). We'll need to import those classes into scope for main.dart.

![undef classes](/images/undef_classes.png)

Let's add that import now to **main.dart**
``` dart

... // import 'login_page.dart'; (line 2)
import 'sign_up_page.dart';
```

We also need to make a configuration update for Android, update minSdkVersion to 21 **./android/app/build.gradle**
``` dart
... //        applicationId "com.example.workshop_app" (line 37)
        minSdkVersion 21
... //         targetSdkVersion 29
```

Now run the app, this will usually take a few minutes to launch.

![Flutter Sign-in](/images/FlutterApp-Module1Photo3-small.3ee0572183c0373455f087ecf1ef349026b1b23a.png)