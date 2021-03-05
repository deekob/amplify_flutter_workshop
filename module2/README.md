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



**5.** To support storing GPS co-ordinates from our Flutter application, we'll need some persistent storage. Amazon DynamoDB is a good fit for our use-case. To start provisioning storage resources in the backend run :
``` bash
amplify add storage
```

Use the following configuration :
``` bash
? Please select from one of the below mentioned services: NoSQL Database

Welcome to the NoSQL DynamoDB database wizard
This wizard asks you a series of questions to help determine how to set up your NoSQL database table.

? Please provide a friendly name for your resource that will be used to label this category in the project: dynamo37da83e0
? Please provide table name: gps_coords

You can now add columns to the table.

? What would you like to name this column: id
? Please choose the data type: string
? Would you like to add another column? Yes
? What would you like to name this column: coords
? Please choose the data type: string
? Would you like to add another column? No

Before you create the database, you must specify how items in your table are uniquely organized. You do this by specifying a primary key. The primary key uniquely identifies each item in the table so that no two items can have the same key. This can be an individual column, or a combination that includes a primary key and a sort key.

To learn more about primary keys, see:
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.PrimaryKey

? Please choose partition key for the table: id
? Do you want to add a sort key to your table? No

You can optionally add global secondary indexes for this table. These are useful when you run queries defined in a different column than the primary key.
To learn more about indexes, see:
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.SecondaryIndexes

? Do you want to add global secondary indexes to your table? No
? Do you want to add a Lambda Trigger for your Table? No

```


**6.** We're created an Amplify application configuration in our local environment, to get the Amplify CLI to create the requested AWS resources, we use the command :
``` bash
amplify push
```

Be sure to answer yes to continue.
``` bash
| Category  | Resource name       | Operation | Provider plugin   |
| --------- | ------------------- | --------- | ----------------- |
| Auth      | workshopapp702c5689 | Create    | awscloudformation |
| Analytics | workshopapp         | Create    | awscloudformation |
| Storage   | dynamo37da83e0      | Create    | awscloudformation |
? Are you sure you want to continue? (Y/n) Y
```

**Congratulations, with your AWS resources successfully deployed, you're now ready to commence Module 3!**

[<- Module 1](../module1/README.md) || [Module 3 ->](../module3/README.md) 
