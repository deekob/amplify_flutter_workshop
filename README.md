# Amplify and Flutter Workshop


## Workshop overview

In this workshop, you will create a mobile application using AWS Amplify and Flutter. The application will have the capability to create a new user in your Amazon Cognito User Pool and store your current GPS co-ordinates in Amazon DynamoDB


## What you will learn
This tutorial will walk you through the steps to create a simple Flutter application discussed above. You will learn to:
* Manage serverless cloud backend using the AWS Amplify CLI
* Authenticate users using Amazon Cognito
* Store data from Flutter to Amazon DynamoDB
* Record analytics events to Amazon Pinpoint

This tutorial will not require any previous knowledge with AWS or any of its services to follow along. However, there will be some more intermediate concepts covered when working with Flutter and Dart. 


## The modules

Please work your way through each module, starting with prerequisites :
* [Prerequisits](./prerequisites/README.md) - Prerequisits for the labs
* [Module 1](./module1/README.md) - Building your Flutter application
* [Module 2](./module2/README.md) - Building your Amplify application
* [Module 3](./module3/README.md) - Configuraing your Flutter application to authenticate against Amazon Cognito


## Cleanup
 
It is recommended to co clean up all the resources created in this workshop once finished to reduce costs.

Delete the AWS Amplify project within the AWS Amplify Console.
``` bash
amplify delete
```

## Questions and contact

For questions on this workshop, or to contact the team, please leave a comment on GitHub.


## License

This sample code is made available under the MIT-0 license. See the LICENSE file.
