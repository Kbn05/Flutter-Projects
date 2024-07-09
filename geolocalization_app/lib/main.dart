import 'dart:convert';
// import 'dart:ffi';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: GeolocationApp(),
    );
  }
}

class GeolocationApp extends StatefulWidget {
  const GeolocationApp({super.key});

  @override
  State<GeolocationApp> createState() => _GeolocationAppState();
}

class _GeolocationAppState extends State<GeolocationApp> {
  Position? _currentPosition;
  late bool serviceEnabled = false;
  late LocationPermission permission;
  String _currentAddress = '';

  Future<Position> _getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            _currentPosition = await _getCurrentLocation();
            setState(() {
              _currentAddress = '$_currentPosition';
            });
            final url = Uri.parse('http://127.0.0.1:8000/location');
            final headers = {
              "Content-Type": "application/json",
              "Accept": "application/json",
            };
            // final body = jsonEncode({
            //   "latitude": _currentPosition!.latitude.toString(),
            //   "longitude": _currentPosition!.longitude.toString(),
            // });
            // print(body.runtimeType);
            final response = await http.post(url,
                headers: headers,
                body: jsonEncode({
                  "latitude": _currentPosition!.latitude.toString(),
                  "longitude": _currentPosition!.longitude.toString(),
                }));
            print(response.body.runtimeType);
            print('Response body: ${response.body}');
            print('Response status: ${response.statusCode}');
            final responseNav = await Get.to(MapsWidget(response.body, {
              "latitude": _currentPosition!.latitude,
              "longitude": _currentPosition!.longitude
            }));
            print('Response from navigation: $responseNav');
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}

class MapsWidget extends StatefulWidget {
  final String location;
  final Map<String, double> dataLocation;
  const MapsWidget(this.location, this.dataLocation, {super.key});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  late GoogleMapController mapController;

  get _center => LatLng(
      widget.dataLocation['latitude']!, widget.dataLocation['longitude']!);

  // final LatLng _center = LatLng(widget.dataLocation['latitude']!, widget.dataLocation['longitude']!);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
