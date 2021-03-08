import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:amplify_flutter/amplify.dart';
// import 'package:flutter_application_1/models/ModelProvider.dart';

class GpsPage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  GpsPage({Key key, this.shouldLogOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Co-ordinates'),
        actions: [
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child:
                GestureDetector(child: Icon(Icons.logout), onTap: shouldLogOut),
          )
        ],
      ),
      body: Container(
        child: GpsSubpage(),
      ),
    );
  }
}

class GpsSubpage extends StatefulWidget {
  @override
  _GpsSubpageState createState() => _GpsSubpageState();
}

class _GpsSubpageState extends State<GpsSubpage> {
  // Set a default GPS location before we quiz for the devices realtime GPS location
  double currentPositionLat = -37.840935;
  double currentPositionLon = 144.946457;

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
    // _addGPSLocationToDB();
  }

  // void _addGPSLocationToDB() async {
  //   GPSCoordinates newGPSCoordinate = GPSCoordinates(
  //       id: "1",
  //       locationName: 'Current Location',
  //       Latitude: 15.3444,
  //       Longitude: 15.3444);
  //   await Amplify.DataStore.save(newGPSCoordinate);
  // }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
        // Create a button that gets the GPS locations on press and stores them into state management
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              // Location
              onPressed: () async {
                var _positionLon;
                var _positionLat;
                await Geolocator.getCurrentPosition().then((value) => {
                      _positionLon = value.longitude,
                      _positionLat = value.latitude,
                    });
                setState(
                  () {
                    currentPositionLon = _positionLon;
                    currentPositionLat = _positionLat;
                  },
                );
                // Call _setNewLocation() within the GPS Location button code so that when you tap it, it will update the Google Maps view and pin
                _setNewLocation();
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.lightBlue,
              child: const Icon(Icons.map, size: 30.0),
            ),
          ),
        ),
        // Shows the current GPS coordinates down in the bottom left hand side of the screen
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Lat: $currentPositionLat    Lon: $currentPositionLon',
              style: TextStyle(
                fontSize: 16,
                background: Paint()..color = Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
