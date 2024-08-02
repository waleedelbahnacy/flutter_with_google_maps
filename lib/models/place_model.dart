import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel 
{
  final int id;
 final String name;
  final LatLng latLng;

  PlaceModel(
    {required this.id,
    required this.name,
     required this.latLng });
}


List<PlaceModel> places = [
  PlaceModel(id: 1, name: 'مسجد الصحابة',latLng:LatLng(30.474044224893813, 31.195337054725993)),
   PlaceModel(id: 2, name: 'مسجد عبدالحليم',latLng:LatLng(30.47192585579614, 31.193606983859226)),
    PlaceModel(id: 3, name: 'كلية التربية الرياضية جامعة بنها الملاعب',latLng:LatLng(30.47767935552993, 31.199836316833526)),
];
