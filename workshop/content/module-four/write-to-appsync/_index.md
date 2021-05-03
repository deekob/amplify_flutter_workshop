+++
title = "Write to AppSync"
date = 2020-04-15T14:32:10+01:00
weight = 42
chapter = true
pre = "<b> </b>"
+++

#### Write GPS CO-ordinates back to AWS AppSync 

Let's create a new function to write the lat and long to AWS AppSync, add the following to **gps_page.dart** within the _GpsSubpageState Class


``` dart
... // (line 29)
  void _addGPSLocationToDB() async {
    try {
      String graphQLDocument =
          '''mutation CreatePoint(\$lat: String!, \$long: String!) {
              createPoint(input: {lat: \$lat, long: \$long}) {
                id
                lat
                long
              }
        }''';
      var variables = {
        "lat": currentPositionLat.toString(),
        "long": currentPositionLon.toString(),
      };
      var request = GraphQLRequest<String>(
          document: graphQLDocument, variables: variables);
      var operation = Amplify.API.mutate(request: request);
      var response = await operation.response;
      var data = response.data;
      print('Mutation result: ' + data);
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }
```

Call the function on button press, add the call below setstate :
``` dart
..   //  }; closing brace of setstate 
_addGPSLocationToDB();
```

We'll need the AWS AppSync endpoint configured in order to write to it, so let's create that.
``` bash
amplify add api 
```

Answer the interactive prompts as per below :
``` bash
? Please select from one of the below mentioned services: GraphQL
? Provide API name: GPS
? Choose the default authorization type for the API API key
? Enter a description for the API key: description
? After how many days from now the API key should expire (1-365): 7
? Do you want to configure advanced settings for the GraphQL API No, I am done.
? Do you have an annotated GraphQL schema? No
? Choose a schema template: Single object with fields (e.g., “Todo” with ID, name, description)
The following types do not have '@auth' enabled. Consider using @auth with @model
         - Todo
Learn more about @auth here: https://docs.amplify.aws/cli/graphql-transformer/auth
GraphQL schema compiled successfully.
Edit your schema at <path>/schema.graphql 
? Do you want to edit the schema now? Yes
```
The schema file should now be available to edit, modify the file to match below.
``` java
type Point @model {
  id: ID!
  lat: String!
  long: String!
}
```
Ensure the file is saved. The below step uses the newly created schema to create resources configured corectly.
``` bash
amplify push
```
Once the AWS resources are fully deployed, the PGS lat and long values will be writen to a DynamoDB table upon pressing the maps button within your Flutter app.

**Congratulations, you have finished the workshop!**

You can either complete the Optional Lab 5 content, or clean up your AWS resources for the workshop now.

### Cleanup
It is recommended to co clean up all the resources created in this workshop once finished to reduce costs.

Delete the AWS Amplify project within the AWS Amplify Console.
``` bash
amplify delete
```