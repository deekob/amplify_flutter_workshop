+++
title = "Adding Google Maps"
date = 2020-04-15T14:32:10+01:00
weight = 51
chapter = true
pre = "<b> </b>"
+++

## Implementation

### Optional: Google Maps
To create the Google Maps API key needed to access the Google Maps service, please use the following steps.

1. Follow the Google Quickstart: https://developers.google.com/maps/gmp-get-started#quickstart
2. Restrict your API key to the Google Maps Android SDK: https://developers.google.com/maps/documentation/android-sdk/get-api-key#restrict_key 
3. 

#### Add Google Maps dependency to Flutter
We'll need to add the google maps library to our apps dependencies, as well as configure Android permissions needed for an end user to share a mobile device location.

Add Google Maps to your ```pubspec.yaml``` file and run ```flutter pub get``` within ```terminal``` (if it doesn't automatically run when saving the file):

``` dart
... // dependencies: (line 23)

google_maps_flutter: ^2.0.1

... // pubspec.yaml
```

Add the following permission to your Android Manifest file, located in ```<project root>/android/app/src/main/AndroidManifest.xml```:

``` java
... // android:icon="@mipmap/ic_launcher"> (line 14)

<meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR API KEY"/>

... // <activity

... // AndroidManifest.xml
```

#### Add Google maps to the app
Open the gps_page.dart file located here: ```<project root>/lib/gps_page.dart``` and add the following into your imports:

``` dart
... // import 'package:geolocator/geolocator.dart'; (line 2)

import 'package:google_maps_flutter/google_maps_flutter.dart';

... // gps_page.dart
```

Now add and initialize the Google Maps controller:

``` dart
... // double currentPositionLon = 144.946457; (line 38)

// Add and initialize the Google Maps controller
GoogleMapController myController;

void _onMapCreated(GoogleMapController controller) {
myController = controller;
}

void _setNewLocation() async {
myController.animateCamera(
    CameraUpdate.newLatLng(
    LatLng(currentPositionLat, currentPositionLon),
    ),
);
}

... // gps_page.dart
```

Next add a view of Google Maps with initial position of Melbourne and drop a marker:

``` dart
... // children: <Widget>[ (line 62)

// Add a view of Google Maps with initial position of Melbourne and drop a marker
GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
        target: LatLng(currentPositionLat, currentPositionLon),
        zoom: 10.0),
    markers: {
        Marker(
            markerId: MarkerId('Melbourne'),
            position: LatLng(currentPositionLat, currentPositionLon),
        )
    },
),

... // gps_page.dart
```

Now call ``` _setNewLocation() ``` within the GPS Location button onPressed code so that when you tap it, it will update the Google Maps view and pin:

``` dart
... // ); (line 95)

// Call _setNewLocation() within the GPS Location button code so that when you tap it, it will update the Google Maps view and pin
_setNewLocation();

... // gps_page.dart
```

You should now be able to see a Google Maps view when you run the app on your device.

![Android Emulator map screen](/images/gps-map.png)

**Congratulations, you have finished the optional workshop!**

If you want an extra challenge post workshop, we'd recommend you take a look at the following areas:

1. Adding in Amplify Datastore, allowing you to have a database stored on the device allowing for offline / online syncing of data from DynamoDB and other database solutions: https://docs.amplify.aws/lib/datastore/getting-started/q/platform/flutter
2. Using Amplify Analytics, allowing you to collect analytics from your app and store on AWS: https://docs.amplify.aws/lib/analytics/getting-started/q/platform/flutter
3. Using Amplify Storage, allowing you to upload photos from a device: https://docs.amplify.aws/lib/storage/getting-started/q/platform/flutter

### Cleanup
It is recommended to co clean up all the resources created in this workshop once finished to reduce costs.

Delete the AWS Amplify project within the AWS Amplify Console.
``` bash
amplify delete
```

We would also recommend deleting the Google Maps API key from Google Console if you completed Optional Lab 5 via the ``` Delete API keys``` step found here: https://developers.google.com/maps/api-key-best-practices
