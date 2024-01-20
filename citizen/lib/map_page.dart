import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'map_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  final double? initialLatitude; // Define initialLatitude and initialLongitude
  final double? initialLongitude;

  const MapScreen({Key? key, this.initialLatitude, this.initialLongitude})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

void main() {
  runApp(const MaterialApp(home: MapScreen()));
}

class _MapScreenState extends State<MapScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Issues Map"),
        backgroundColor: const Color(0xFF21222D),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialZoom: 13,
          initialCenter: LatLng(
            widget.initialLatitude ?? 0.0, // Use the provided coordinates
            widget.initialLongitude ?? 0.0,
          ),
        ),
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
                point: const LatLng(28.557020, 77.326240),
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
                point: const LatLng(28.549892, 77.328524),
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
                point: const LatLng(28.560570, 77.363197),
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
                point: const LatLng(28.587362, 77.313053),
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
                point: const LatLng(28.547329, 77.337370),
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
                point: const LatLng(28.566257, 77.379015),
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
                point: const LatLng(28.595200, 77.339851),
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
              Marker(
                point: const LatLng(28.532481, 77.347409),
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
                point: const LatLng(28.536703, 77.438106),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => getCoordinates(),
        child: const Icon(
          Icons.route,
          color: Colors.white,
        ),
      ),
    );
  }
}
