+++
title = "Configure Amplify"
date = 2020-04-15T14:32:10+01:00
weight = 22
chapter = false
pre = "<b> </b>"
+++

## Implementation

If you have not already configured your Amplify CLI, be sure to run this:
``` bash
amplify configure
```
You will be guided through the configuration process. You can go Install and configure [here](https://docs.amplify.aws/cli/start/install#option-2-follow-the-instructions) for more information on configuring the CLI.


To create an Amplify project, you must initialize and configure the project at the root directory of your project.

**1.** Navigate to the root of your project:

``` bash
cd workshop_app
```
Verify that you are in the correct directory by running $ ls . Your output should list folders similar to below :

``` bash
➜  awsjs@f8ffc2296246 workshop_app % ls
README.md               build                   lib                     pubspec.yaml            workshop_app.iml
android                 ios                     pubspec.lock            test
```

**2.** Now initialize your project Amplify project by executing:
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

**3.** Next, we'll add auth to our amplify app, it's as simple as the below command with a couple of configuration items. Simply run :
``` bash
amplify add auth
```

Answer the questions as per below.
``` bash
 Do you want to use the default authentication and security configuration? Default configuration
 Warning: you will not be able to edit these selections. 
 How do you want users to be able to sign in? Username
 Do you want to configure advanced settings? No, I am done.
 ```

**4.** To support events being sent from our application, we'll create an Amazon Pinpoint resource. Execute the following command :
``` bash
amplify add analytics
```

Answer the questions as per below.
``` bash
awsjs@f8ffc2296246 workshop_app % amplify add analytics
? Select an Analytics provider Amazon Pinpoint
? Provide your pinpoint resource name: workshopapp
Auth configuration is required to allow unauthenticated users, but it is not configured properly.
Adding analytics would add the Auth category to the project if not already added.
? Apps need authorization to send analytics events. Do you want to allow guests and unauthenticated users to send analytics events? (we recommend you allow this when getting started) Yes
```

**5.** We're created an Amplify application configuration in our local environment, to get the Amplify CLI to create the requested AWS resources, we use the command :
``` bash
amplify push
```

Be sure to answer yes to continue.
``` bash
| Category  | Resource name       | Operation | Provider plugin   |
| --------- | ------------------- | --------- | ----------------- |
| Auth      | workshopapp702c5689 | Create    | awscloudformation |
| Analytics | workshopapp         | Create    | awscloudformation |
? Are you sure you want to continue? (Y/n) Y
```

**Congratulations, with your AWS resources successfully deployed, you're now ready to commence Module 3!**




