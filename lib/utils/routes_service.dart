import 'dart:convert';

import 'package:flutter_with_google_maps/models/location_info/lat_lng.dart';
import 'package:flutter_with_google_maps/models/location_info/location.dart';
import 'package:flutter_with_google_maps/models/location_info/location_info.dart';
import 'package:flutter_with_google_maps/models/routes_model/routes_model.dart';
import 'package:flutter_with_google_maps/models/routes_model/routes_modifiers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
class RoutesService 
{
  final String baseUrl = 
  'https://routes.googleapis.com/directions/v2:computeRoutes';
  final String apiKey = 'AIzaSyC87Tt3tfO6aYids0BZStXXbrdAy05jQCI';
  Future<RoutesModel> fetchRoutes(
    {required LocationInfoModel origin ,
     required LocationInfoModel destination,
     RoutesModifiers? routesModifiers }) async
  {
  Uri url =Uri.parse(baseUrl);

  Map<String, String> headers = {
    'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  };
  
  Map<String , dynamic> body = {
    "origin": origin.toJson(),
      "destination": destination.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": routesModifiers != null
          ? routesModifiers.toJson()
          : RoutesModifiers().toJson(),
      "languageCode": "en-US",
      "units": "IMPERIAL"
  };
var response = await http.post(url,
headers: headers,
body: jsonEncode(body),
);
if(response.statusCode == 200)
{
  return RoutesModel.fromJson(jsonDecode(response.body));
}else
{
  throw Exception('No routes found'); 
}
  }

   
   
}