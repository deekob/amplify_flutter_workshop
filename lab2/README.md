# Lab 1

## Introduction
Now that you have implemented the Flutter app, you can move onto initializing your Amplify project.

At this point, you will need to have the Amplify CLI installed on your machine. Once installed, we will initialize Amplify at the root directory of our project, install the Amplify dependencies into our project, and ensure Amplify is properly configured during each run of our app.

## What You Will Learn
* Initialize a new Amplify project from the command line
* Add Amplify as a dependency for your project
* Initialize Amplify libraries at runtime

## Key Concepts
* Amplify CLI – The Amplify CLI allows you to create, manage, and remove AWS services directly from your terminal.
* Amplify Libraries – The Amplify libraries allow you to interact with AWS services from a web or mobile application.

## Implementation

If you have not already configured your Amplify CLI, be sure to run this:
``` bash
amplify configure
```
You will be guided through the configuration process. You can go Install and configure [here](https://docs.amplify.aws/cli/start/install#option-2-follow-the-instructions) for more information on configuring the CLI.


To create an Amplify project, you must initialize and configure the project at the root directory of your project.

**1.** Navigate to the root of your project:

``` bash
cd path/to/your/project
```
Verify that you are in the correct directory by running $ ls -al . Yout output should list folders similar to below :

``` bash
➜  photo_gallery git:(master) ✗ ls -al
total 80
drwxr-xr-x  18 kiloloco  staff   576 Oct 19 18:07 .
drwxr-xr-x   3 kiloloco  staff    96 Oct 18 21:10 ..
drwxr-xr-x   4 kiloloco  staff   128 Oct 18 22:15 .dart_tool
-rw-r--r--   1 kiloloco  staff   536 Oct 19 19:43 .flutter-plugins
-rw-r--r--   1 kiloloco  staff  1422 Oct 19 19:43 .flutter-plugins-dependencies
-rw-r--r--   1 kiloloco  staff   621 Oct 18 21:10 .gitignore
drwxr-xr-x   6 kiloloco  staff   192 Oct 18 21:10 .idea
-rw-r--r--   1 kiloloco  staff   305 Oct 18 21:10 .metadata
-rw-r--r--   1 kiloloco  staff  3648 Oct 19 18:07 .packages
-rw-r--r--   1 kiloloco  staff   543 Oct 18 21:10 README.md
drwxr-xr-x  12 kiloloco  staff   384 Oct 18 21:10 android
drwxr-xr-x   5 kiloloco  staff   160 Oct 18 22:20 build
drwxr-xr-x  11 kiloloco  staff   352 Oct 19 19:04 ios
drwxr-xr-x  11 kiloloco  staff   352 Oct 19 18:08 lib
-rw-r--r--   1 kiloloco  staff   896 Oct 18 21:10 photo_gallery.iml
-rw-r--r--   1 kiloloco  staff  6047 Oct 19 18:07 pubspec.lock
-rw-r--r--   1 kiloloco  staff  2926 Oct 19 18:07 pubspec.yaml
drwxr-xr-x   3 kiloloco  staff    96 Oct 18 21:10 test
```

**2.** Now initialize your project Amplify project:
``` bash
amplify init
```
You should now be prompted with several questions on how to configure your project. If you press the Enter key for each question, it will give the default answer to each question, resulting in an output that should look similar to this:
``` bash
➜  photo_gallery git:(master) ✗ amplify init
Note: It is recommended to run this command from the root of your app directory
? Enter a name for the project photogallery
? Enter a name for the environment dev
? Choose your default editor: Visual Studio Code
? Choose the type of app that you\'re building flutter
Please tell us about your project
⚠️  Flutter project support in the Amplify CLI is in DEVELOPER PREVIEW.
Only the following categories are supported:
 * Auth
 * Analytics
 * Storage
? Where do you want to store your configuration file? ./lib/
Using default provider  awscloudformation

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html

? Do you want to use an AWS profile? Yes
? Please choose the profile you want to use default
```
After the CLI has finished crating your project in the cloud, you should get an output like this:
``` bash
✔ Successfully created initial AWS cloud resources for deployments.
✔ Initialized provider successfully.
Initialized your environment successfully.

Your project has been successfully initialized and connected to the cloud!
```

**3.** 
``` bash
amplify add auth
```
**4.**
``` bash
amplify add analytics
```
**5.**
``` bash
amplify push
```

[<- Prerequisites](../prerequisites/README.md) || [Lab2 ->](../lab2/README.md) 
