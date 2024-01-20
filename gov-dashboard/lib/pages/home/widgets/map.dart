import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

class ProblemMap extends StatefulWidget {
  const ProblemMap({super.key});

  @override
  _ProblemMapState createState() => _ProblemMapState();
}

class _ProblemMapState extends State<ProblemMap> {
  // GoogleMapController? _controller;

  // final Set<Marker> allMarkers = Set<Marker>.from([
  //   Marker(
  //     markerId: MarkerId('1'),
  //     position: LatLng(37.7749, -122.4194), // Replace with actual coordinates
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //     infoWindow: InfoWindow(title: 'Water Issue'),
  //   ),
  //   Marker(
  //     markerId: MarkerId('2'),
  //     position: LatLng(37.7749, -122.4194), // Replace with actual coordinates
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //     infoWindow: InfoWindow(title: 'Electricity Issue'),
  //   ),
  //   // Add more markers for other issues with different colors
  // ]);

  // Raw coordinates got from  OpenRouteService
  List listOfPoints = [];

  // Conversion of listOfPoints into LatLng(Latitude, Longitude) list of points
  List<LatLng> points = [];

  // Method to consume the OpenRouteService API
  getCoordinates() async {
    // Requesting for openrouteservice api
    var response = await http.get(getRouteUrl(
        "1.243344,6.145332", '1.2160116523406839,6.125231015668568'));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Set the desired height
      width: 700, // Set the desired width
      // child: GoogleMap(
      //   onMapCreated: (controller) {
      //     setState(() {
      //       _controller = controller;
      //     });
      //   },
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(37.7749, -122.4194), // Initial map coordinates
      //     zoom: 12.0,
      //   ),
      //   markers: allMarkers,
      // ),
      child: FlutterMap(
        options: const MapOptions(
            initialZoom: 13, initialCenter: LatLng(28.6465, 77.1169)),
        children: [
          // Layer that adds the map
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            // Plenty of other options available!
          ),
          // Layer that adds points the map
          MarkerLayer(
            markers: [
              // First Marker
              Marker(
                point: const LatLng(28.645026, 77.111367),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 30,
                ),
              ),
              Marker(
                point: const LatLng(28.642239, 77.107332),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.652257, 77.105014),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.635308, 77.117368),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.650072, 77.157783),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.646984, 77.150849),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.619186, 77.066182),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.655947, 77.075358),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.water_drop),
                  color: Colors.blue,
                  iconSize: 31,
                ),
              ),
              // Second Marker
              Marker(
                point: const LatLng(28.635986, 77.112825),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.630185, 77.123206),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.652972, 77.133432),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.638171, 77.161229),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.611576, 77.102631),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.627021, 77.064772),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.672666, 77.061292),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                  color: Colors.black,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.666491, 77.047213),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.608336, 77.041114),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.63124, 77.115916),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.631918, 77.131701),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.633349, 77.090351),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.674097, 77.113077),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.66491, 77.100036),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.628001, 77.077809),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on),
                  color: Colors.green,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.652972, 77.101269),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on),
                  color: Colors.green,
                  iconSize: 31,
                ),
              ),
              Marker(
                point: const LatLng(28.639225, 77.073515),
                width: 80,
                height: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on),
                  color: Colors.green,
                  iconSize: 31,
                ),
              ),
            ],
          ),

          // Polylines layer
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(points: points, color: Colors.black, strokeWidth: 5),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Problem Map Example'),
      ),
      body: const ProblemMap(),
    ),
  ));
}
