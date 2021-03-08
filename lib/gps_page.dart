import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  // Location
  double currentPositionLat = -37.840935;
  double currentPositionLon = 144.946457;

  // Maps
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

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
                _setNewLocation();
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.lightBlue,
              child: const Icon(Icons.map, size: 30.0),
            ),
          ),
        ),
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
