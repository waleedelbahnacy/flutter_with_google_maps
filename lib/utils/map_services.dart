import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/models/location_info/lat_lng.dart';
import 'package:flutter_with_google_maps/models/location_info/location.dart';
import 'package:flutter_with_google_maps/models/location_info/location_info.dart';
import 'package:flutter_with_google_maps/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:flutter_with_google_maps/models/routes_model/routes_model.dart';
import 'package:flutter_with_google_maps/utils/google_maps_place_service.dart';
import 'package:flutter_with_google_maps/utils/location_service.dart';
import 'package:flutter_with_google_maps/utils/routes_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServices
{
  PlacesService PlaceService = PlacesService();
  LocationService locationService = LocationService();
  RoutesService routesService = RoutesService();

  getPredictions({required String input, required String sessionToken ,required List<PlaceModel> places})async
  {
        if (input.isNotEmpty) {
  var result = await  PlaceService.getPredictions(
    sessionToken: sessionToken,
    input:input);
  places.clear();
places.addAll(result);

}else
{
  places.clear();

 
} 
  }

    Future<List<LatLng>> getRouteData({required LatLng currentLocation ,required LatLng destination })async
   {
    LocationInfoModel origin = LocationInfoModel
    (
      location: LocationModel(
        latLng: LatLngModel(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        ),
      ),
    );
    LocationInfoModel destination = LocationInfoModel
    (
      location: LocationModel(
        latLng: LatLngModel(
          latitude: destination.latitude,
          longitude: destination.longitude,
        ),
      ),
    );
  RoutesModel routes = await  routesService.fetchRoutes(
    origin: origin, destination: destination);
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = getDecodedRoute(polylinePoints, routes);

  return points;
   }

    List<LatLng> getDecodedRoute(polylinePoints polylinePoints, RoutesModel routes) {
    List<PointLatLng> result =
     polylinePoints.decodePolyline(routes.routes!.first.polyline!.encodedPolyline!);
     
      List<LatLng> points = 
      result.map((e) => LatLng(e.latitude,e.longitude)).toList();
    return points;
  }

 void displayRoute(List<LatLng> points, {required Set<Polyline> polyLines, required GoogleMapController googleMapController }) 
  {
    Polyline route = Polyline(
      color: Colors.blue,
      width: 5,
      polylineId: const PolylineId('route'), 
    points:points,
     );

     polyLines.add(route);

     LatLngBounds bounds = getLatLngBounds(points);
            googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));

     setState(() {
     });


   LatLngBounds getLatLngBounds(List<LatLng> points) 
  {
     var southWestLatitude = points.first.latitude;
     var southWestLongitude = points.first.longitude;
     var northEastLatitude = points.first.latitude;
     var northEastLongitude = points.first.longitude;

     for(var point in points)
     {
      southWestLatitude = min(southWestLatitude, point.latitude);
      southWestLongitude = min(southWestLongitude, point.longitude);
      northEastLatitude = max(northEastLatitude, point.latitude);
      northEastLongitude = max(northEastLongitude, point.longitude);
     }
  return LatLngBounds(southwest: LatLng(southWestLatitude, southWestLongitude), northeast: LatLng(northEastLatitude, northEastLongitude));
  }
  }
}