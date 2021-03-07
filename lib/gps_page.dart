import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

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
  // var location = new Location();
  // Map<String, double> userLocation;

  // Maps
  GoogleMapController myController;

  final LatLng _center = const LatLng(-37.840935, 144.946457);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // userLocation == null
        //     ? CircularProgressIndicator()
        //     : Text("Location:" +
        //         userLocation["latitude"].toString() +
        //         " " +
        //         userLocation["longitude"].toString()),
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 10.0,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(14.0),
        //   child: Align(
        //     alignment: Alignment.topRight,
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         _getLocation().then((value) {
        //           setState(() {
        //             userLocation = value;
        //           });
        //         });
        //       },
        //       materialTapTargetSize: MaterialTapTargetSize.padded,
        //       backgroundColor: Colors.lightBlue,
        //       child: const Icon(Icons.map, size: 30.0),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Future<Map<String, double>> _getLocation() async {
  //   var currentLocation = <String, double>{};
  //   try {
  //     currentLocation = (await location.getLocation()) as Map<String, double>;
  //   } catch (e) {
  //     currentLocation = null;
  //   }
  //   print(currentLocation);
  //   return currentLocation;
  // }
}
