# Amplify and Flutter Workshop

## Workshop Overview

In this workshop, you will create a mobile application using AWS Amplify and Flutter. The application will have the capability to create a new user in your Amazon Cognito User Pool and store your current GPS co-ordinates in Amazon DynamoDB

Lab 1 is a pre-requisite to be able to complete Labs 2 and/or 3.

## Prerequisites

In order to complete this workshop you'll need an AWS Account with sufficient permission to create AWS IAM, Amazon DynamoDB, Amazon Cognito and AWS Amplify resources.

## The Labs

* [Lab 1](./lab1-Building_Chat_Bots_With_Lex/README.md) - Building your first Amazon Lex chatbot
* [Lab 2](./lab2-Building_Web_App_With_Amplify/README.md) - Building your Web App with Amplify and configuring LEX
* [Lab 3 - Optional](./lab3-Building_Amazon_Connect_Contact_Center_Environment) - Creating your first call center using Amazon Connect and configuring LEX

## Questions and Contact

For questions on the AWS Lex and Amplify Workshop, or to contact the team, please leave a comment on GitHub.

## Cleanup
 
To clean up all the resources created in this workshop:

* Delete the AWS Amplify project within the AWS Amplify Console.
``` bash
amplify delete
```

## License

This sample code is made available under the MIT-0 license. See the LICENSE file.




(sudo) npm install -g @aws-amplify/cli

If you have not already configured your Amplify CLI, be sure to run this:
amplify configure
You will be guided through the configuration process. You can go here for more information on configuring the CLI.

(cd ~/Code/flutter_1/flutter_application_1)
amplify init

amplify add auth

amplify add analytics

amplify push

