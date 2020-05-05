import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MapPage());

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng latlng = LatLng(
    45.75,
    4.85,
  );
  Iterable markers = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    try {
      final response = await http.get(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=45.75,4.85&radius=1500&type=velov&key=AIzaSyC9QbAZk7eQ2Su85xmHtie4J0J6HqYtEFw');

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        Iterable _markers = Iterable.generate(10, (index) {
          Map result = results[index];
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

          return Marker(
              markerId: MarkerId("marker$index"), position: latLngMarker);
        });

        setState(() {
          markers = _markers;
        });
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // OU AVEC L'API OPEN DATA SOFT (ESSAI)

  /* getData() async {
    try {
      final response =
          await rootBundle.loadString('assets/api/station-velov.json');
      Map responseBody = json.decode(response);
      List results = responseBody["geometry"];

      Iterable _markers = Iterable.generate(10, (index) {
        Map result = results[index];
        Map location = result["coordinates"];
        LatLng latLngMarker = LatLng(location[0], location[1]);

        return Marker(
            markerId: MarkerId("marker$index"), position: latLngMarker);
      });

      setState(() {
        markers = _markers;
      });
    } catch (e) {
      print(e.toString());
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.from(
          markers,
        ),
        initialCameraPosition: CameraPosition(target: latlng, zoom: 13.75),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}
