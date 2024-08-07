import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/views/google_map_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const RouteTrackApp());
}
class RouteTrackApp extends StatelessWidget {
  const RouteTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: GoogleMapView()),
        ),
    );
  }
}