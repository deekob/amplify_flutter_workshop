# Amplify and Flutter Workshop


## Workshop overview

In this workshop, you will create a mobile application using AWS Amplify and Flutter. The application will have the capability to create a new user in your Amazon Cognito User Pool and view your current GPS co-ordinates

This tutorial will not require any previous knowledge with AWS or any of its services to follow along. However, there will be some more intermediate concepts covered when working with Flutter and Dart. 

## The modules

Please work your way through each module, starting with prerequisites :
* [Prerequisites](./prerequisites/README.md) - Prerequisites for the labs
* [Module 1](./module1/README.md) - Building your Flutter application
* [Module 2](./module2/README.md) - Building your Amplify application
* [Module 3](./module3/README.md) - Configuring your Flutter application to authenticate against Amazon Cognito
* [Module 4](./module4/README.md) - Calling GPS coordinates of device and sdisplaying on screen
* [Optional: Module 5](./module5/README.md) - Display Google Maps showing GPS coordinates of the device

## Cleanup
 
It is recommended to co clean up all the resources created in this workshop once finished to reduce costs.

Delete the AWS Amplify project within the AWS Amplify Console.
``` bash
amplify delete
```

We would also recommend deleting the Google Maps API key from Google Console if you completed Optional Lab 5 via the ``` Delete API keys``` step found here: https://developers.google.com/maps/api-key-best-practices

## Questions and contact

For questions on this workshop, or to contact the team, please leave a comment on GitHub.


## License

This sample code is made available under the MIT-0 license. See the LICENSE file.
