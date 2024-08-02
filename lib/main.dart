import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/widgets/google_map_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const RouteTrackApp());
}
class RouteTrackApp extends StatelessWidget {
  const RouteTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GoogleMapView(),
    );
  }
}