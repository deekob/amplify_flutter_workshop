+++
title = "Adding GPS Dependancies"
date = 2020-04-15T14:32:10+01:00
weight = 41
chapter = true
pre = "<b> </b>"
+++

## Implementation

### Accessing GPS Coordinates

#### Add GPS location dependencies to Flutter

Add a GPS location library to your ```pubspec.yaml``` file and run ```flutter pub get``` within ```terminal``` (if it doesn't automatically run when saving the file):

``` dart
... // dependencies: (line 23)

geolocator: ^6.2.1

... // pubspec.yaml
```

#### Configure Android Permission 

Add the following permission to your Android Manifest file, located in ```<project root>/android/app/src/main/AndroidManifest.xml```:

``` java
... // <manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.workshop_app">
... // (line 3)

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.INTERNET"/>

... // <application android:label=...
```

If you are using an Android Emulator please set up a fake location for this lab:

![Android Emulator screen](/images/android-location-set-1.png)

1.  Open the Android Emulator and navigate to the settings screen

![Android Emulator settings](/images/android-location-set-2.png)

2. Within the location tab, type a location into the search and click save point. This will be where the emulator thinks that it is located when the app asks for a GPS location


#### Configure IoS Permission

Add the following permisssion to ```<project root>/ios/Runner/Info.plist```:

``` xml
/// ... <dict> (line 4)
<key>NSLocationAlwaysUsageDescription</key>
<string>Needed to access location</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Needed to access location</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs access to location when open and in the background.</string>
```