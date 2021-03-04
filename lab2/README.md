# Module 2

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
cd Code/workshop_app
```
Verify that you are in the correct directory by running $ ls . Yout output should list folders similar to below :

``` bash
➜  awsjs@f8ffc2296246 workshop_app % ls
README.md               build                   lib                     pubspec.yaml            workshop_app.iml
android                 ios                     pubspec.lock            test
```

**2.** Now initialize your project Amplify project:
``` bash
amplify init
```
You should now be prompted with several questions on how to configure your project. If you press the Enter key for each question, it will give the default answer to each question, resulting in an output that should look similar to this:
``` bash
➜  photo_gallery git:(master) ✗ amplify init
Note: It is recommended to run this command from the root of your app directory
? Enter a name for the project workshopapp
? Enter a name for the environment dev
? Choose your default editor: Visual Studio Code
? Choose the type of app that you\'re building flutter
Please tell us about your project
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

``` bash
 Do you want to use the default authentication and security configuration? Default configuration
 Warning: you will not be able to edit these selections. 
 How do you want users to be able to sign in? Username
 Do you want to configure advanced settings? No, I am done.
 ```

**4.**
``` bash
amplify add analytics
```

``` bash
awsjs@f8ffc2296246 workshop_app % amplify add analytics
? Select an Analytics provider Amazon Pinpoint
? Provide your pinpoint resource name: workshopapp
Auth configuration is required to allow unauthenticated users, but it is not configured properly.
Adding analytics would add the Auth category to the project if not already added.
? Apps need authorization to send analytics events. Do you want to allow guests and unauthenticated users to send analytics events? (we recommend you allow this when getting started) Yes
```


**5.**
``` bash
amplify push
```
``` bash
| Category  | Resource name       | Operation | Provider plugin   |
| --------- | ------------------- | --------- | ----------------- |
| Auth      | workshopapp702c5689 | Create    | awscloudformation |
| Analytics | workshopapp         | Create    | awscloudformation |
? Are you sure you want to continue? (Y/n) Y
```


[<- Prerequisites](../prerequisites/README.md) || [Lab 3 ->](../lab3/README.md) 
