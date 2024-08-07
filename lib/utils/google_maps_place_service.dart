import 'dart:convert';

import 'package:flutter_with_google_maps/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:flutter_with_google_maps/models/place_details_model/place_details_model.dart';
import 'package:http/http.dart' as http;

class GoogleMapsPlaceService 
{
final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyC87Tt3tfO6aYids0BZStXXbrdAy05jQCI';

  Future<List<PlaceModel>> getPredictions(
    {required String input, required String sessionToken }) async
  {
  var response = await  http.get(Uri.parse('$baseUrl/autocomplete/json?key=$apiKey&input=$input&sessiontoken=$sessionToken'));

   if(response.statusCode == 200)
   {
  var data = jsonDecode(response.body)['predictions'];
  List<PlaceModel> places = [];

  for (var item in data) {
    places.add(PlaceModel.fromJson(item));
  }
  return places;
   }else
   {
    throw Exception();
   }
  }

  Future<PlaceDetailsModel> getPlaceDetails(
    {required String placeid}) async
  {
  var response = await  http.get(Uri.parse('$baseUrl/details/json?key=$apiKey&place_id=$placeid'));

   if(response.statusCode == 200)
   {
  var data = jsonDecode(response.body)['result'];
 
return PlaceDetailsModel.fromJson(data);
   }else
   {
    throw Exception();
   }

  }
  
  }
