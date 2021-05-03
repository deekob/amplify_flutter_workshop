+++
title = "Adding Open Street Maps"
date = 2020-04-15T14:32:10+01:00
weight = 51
chapter = true
pre = "<b> </b>"
+++

## Implementation

#### Add Maps dependency to Flutter
We'll need to add the maps library to our apps dependencies, as well as configure Android permissions needed for an end user to share a mobile device location.

Add the Maps library to your ```pubspec.yaml``` file and run ```flutter pub get``` within ```terminal``` (if it doesn't automatically run when saving the file):

``` dart
... // dependencies: (line 23)

latlong: ^0.6.1
flutter_map: ^0.12.0

... // pubspec.yaml
```

Add the following permission to your Android Manifest file, located in ```<project root>/android/app/src/main/AndroidManifest.xml```:

``` java
... // android:icon="@mipmap/ic_launcher"> (line 14)

<meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR API KEY"/>

... // <activity

... // AndroidManifest.xml
```

#### Add maps to the app
Open the gps_page.dart file located here: ```<project root>/lib/gps_page.dart``` and add the following into your imports:

``` dart
... // import 'package:geolocator/geolocator.dart'; (line 2)

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

... // gps_page.dart
```

Next add a view of Open Street Maps with initial position of our GPS coordinates:

``` dart
... // children: <Widget>[ (line 48)

// Add a view of  Maps with initial position of Melbourne
FlutterMap(
    options: new MapOptions(
    center: LatLng(currentPositionLat, currentPositionLon),
    zoom: 13.0,
    ),
    layers: [
    new TileLayerOptions(
        urlTemplate:
            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']),
    ],
),

... // gps_page.dart
```


You should now be able to see a Open Street Maps view when you run the app on your device.

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