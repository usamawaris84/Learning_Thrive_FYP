import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:developer';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.arguments}) : super(key: key);
  final locationArguments arguments;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers = {};

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(widget.arguments.latitude, widget.arguments.longitude),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('Home'), 
            position: LatLng(widget.arguments.latitude, widget.arguments.longitude)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    double latitude = widget.arguments.latitude;
    double longitude = widget.arguments.longitude;
    log("object");
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(48.8561, 2.2930),
            zoom: 12.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: _markers,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          getLocation();
        },
      ),
    );
  }
}

class locationArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;
  final double longitude;
  final double latitude;

  locationArguments(
      {required this.peerId,
      required this.peerAvatar,
      required this.peerNickname,
      required this.longitude,
      required this.latitude,
      String? current,
      String? currentid});
}
