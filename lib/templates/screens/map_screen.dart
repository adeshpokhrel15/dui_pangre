import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng? userPos;
  LocationPermission? permission;
  bool isLoading = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.7, 85.30),
    // zoom: 14.4746,
    zoom: 16,
  );

  // static final Marker _kMarker = Marker(markerId: MarkerId( '_testMarker'),
  static final Marker _firstOfficeMarker = Marker(
    markerId: MarkerId('_firstMarker'),
    position: LatLng(27.700769, 85.300140),
    infoWindow: InfoWindow(
      title: 'First Office',
      snippet: 'Marker Snippet',
    ),
    onTap: () {
      // Handle marker tap, if needed
    },
  );

  static final Marker _secondOfficeMarker = Marker(
    markerId: MarkerId('_secondMarker'),
    position: LatLng(27.70476, 85.30240),
    infoWindow: InfoWindow(
      title: 'Second Office',
      snippet: 'Marker Snippet',
    ),
    onTap: () {
      // Handle marker tap, if needed
    },
  );
  static final Marker _thirdOfficeMarker = Marker(
    markerId: MarkerId('_thirdMarker'),
    position: LatLng(27.800769, 85.302240),
    infoWindow: InfoWindow(
      title: 'Third Office',
      snippet: 'Marker Snippet',
    ),
    onTap: () {
      // Handle marker tap, if needed
    },
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  _getLocationPermission() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle the case when the user denies permission
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case when the user has previously denied permission permanently
      // and you need to guide them to the app settings
    }
  }

  @override
  void initState() {
    _getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    markers[MarkerId('_firstMarker')] = _firstOfficeMarker;
    markers[MarkerId('_secondMarker')] = _secondOfficeMarker;
    markers[MarkerId('_thirdMarker')] = _thirdOfficeMarker;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            // markers: {_fristOfficeMarker, _secondOfficeMarker, _thirdOfficeMarker},
            markers: Set<Marker>.of(markers.values),
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          if (isLoading)
            Center(
                child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 75,
              width: 75,
              child: CircularProgressIndicator(
                strokeWidth: 5,
              ),
            )),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        buttonSize: Size(56, 56),
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.easeInOut,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        backgroundColor: Colors.blue,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.location_searching),
            backgroundColor: Colors.blue,
            label: 'See your location',
            onTap: _goToUser,
          ),
          SpeedDialChild(
            child: Icon(Icons.fmd_bad),
            backgroundColor: Colors.red,
            label: 'Find nearest outlet',
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              final GoogleMapController controller = await _controller.future;
              if (userPos == null) {
                Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );

                double latitude = position.latitude;
                double longitude = position.longitude;

                // userPos = LatLng(37.43296265331129, -122.08832357078792);
                userPos = LatLng(latitude, longitude);
              }

              double distanceWithFirst = await Geolocator.distanceBetween(
                userPos!.latitude,
                userPos!.longitude,
                _firstOfficeMarker.position.latitude,
                _firstOfficeMarker.position.longitude,
              );
              double distanceWithSecond = await Geolocator.distanceBetween(
                userPos!.latitude,
                userPos!.longitude,
                _secondOfficeMarker.position.latitude,
                _secondOfficeMarker.position.longitude,
              );
              double distanceWithThird = await Geolocator.distanceBetween(
                userPos!.latitude,
                userPos!.longitude,
                _thirdOfficeMarker.position.latitude,
                _thirdOfficeMarker.position.longitude,
              );

              double smallestDistance;

              if (distanceWithFirst <= distanceWithSecond &&
                  distanceWithFirst <= distanceWithThird) {
                smallestDistance = distanceWithFirst;
              } else if (distanceWithSecond <= distanceWithFirst &&
                  distanceWithSecond <= distanceWithThird) {
                smallestDistance = distanceWithSecond;
              } else {
                smallestDistance = distanceWithThird;
              }

              setState(() {
                isLoading = false;
              });

              if (smallestDistance == distanceWithFirst) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(days: 1),
                  content: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    // height: 10,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'First office is the nearest from your location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    bearing: 192.8334901395799,
                                    target: LatLng(
                                        _firstOfficeMarker.position.latitude,
                                        _firstOfficeMarker.position.longitude),
                                    tilt: 59.440717697143555,
                                    zoom: 19.151926040649414)));
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Text('See office location'),
                        ),
                      ],
                    ),
                  ),
                ));
              } else if (smallestDistance == distanceWithSecond) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(days: 1),
                  content: Container(
                    padding: EdgeInsets.all(8),
                    // height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Second office is the nearest from your location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    bearing: 192.8334901395799,
                                    target: LatLng(
                                        _secondOfficeMarker.position.latitude,
                                        _secondOfficeMarker.position.longitude),
                                    tilt: 59.440717697143555,
                                    zoom: 19.151926040649414)));
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Text('See office location'),
                        ),
                      ],
                    ),
                  ),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(days: 1),
                  content: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Third office is the nearest from your location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    bearing: 192.8334901395799,
                                    target: LatLng(
                                        _thirdOfficeMarker.position.latitude,
                                        _thirdOfficeMarker.position.longitude),
                                    tilt: 59.440717697143555,
                                    zoom: 19.151926040649414)));
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Text('See office location'),
                        ),
                      ],
                    ),
                  ),
                ));
              }
            },
          ),

          // Add more SpeedDialChild widgets for additional actions
        ],
      ),
    );
  }

  Future<void> _goToUser() async {
    setState(() {
      isLoading = true;
    });

    if (userPos == null) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      // userPos = LatLng(37.43296265331129, -122.08832357078792);
      userPos = LatLng(latitude, longitude);
    }

    CameraPosition _userPos = CameraPosition(
      bearing: 192.8334901395799,
      // target: LatLng(37.43296265331129, -122.08832357078792),
      target: LatLng(userPos!.latitude, userPos!.longitude),
      tilt: 59.440717697143555,
      zoom: 16,
    );

    final Marker _userMarker = Marker(
      markerId: MarkerId('_userMarker'),
      position: LatLng(userPos!.latitude, userPos!.longitude),
      infoWindow: InfoWindow(
        title: 'User Marker',
        snippet: 'Marker Snippet',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      // icon: await BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration(
      //       devicePixelRatio: 2.5), // Adjust devicePixelRatio as needed
      //   'assets/google_maps_user_icon.png',
      // ),
      onTap: () {
        // Handle marker tap, if needed
      },
    );

    setState(() {
      isLoading = false;
    });
    setState(() {
      markers[MarkerId('_userMarker')] = _userMarker;
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userPos));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
