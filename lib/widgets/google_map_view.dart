import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:flutter_with_google_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;

import 'package:location/location.dart';
class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
 late CameraPosition initialCameraPosition;

late LocationService locationService;
 @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom : 1,
      target: LatLng(30.472915651222554, 31.171548537357236));
     
      locationService = LocationService();
    // updateMyLocation();
    updateMyLocation();
    super.initState();
  }
  bool isFirstCall = true;
  GoogleMapController ? googleMapController;
 
  Set<Marker> markers = {};
 
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      zoomControlsEnabled: false,
      
          onMapCreated: (controller) {
            googleMapController = controller;
      initMapStyle();

          } ,
            initialCameraPosition: initialCameraPosition
    );
        
      
  
  
  }
  
  void initMapStyle() async{
  var nightMapStyle = await DefaultAssetBundle.of(context)
  .loadString('assets/map_styles/night_map_style.json');
    googleMapController!.setMapStyle(nightMapStyle);

  }
  

 
 
  void updateMyLocation() async
  {
  await  locationService.checkAndRequestLocationPermission();
  var hasPermission =  await locationService.checkAndRequestLocationPermission();
  if (hasPermission) {
   locationService.getRealTimeLocationData((LocationData){

    setMyLocationMarker(LocationData);
          updateMyCamera(LocationData);
   });
  }else{

  }
  }

  void updateMyCamera(LocationData LocationData) {

    
          
    if (isFirstCall) {

CameraPosition cameraPosition = CameraPosition(target: 
    LatLng(LocationData.latitude!, LocationData.longitude!),
    zoom: 17);
  googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  isFirstCall = false;
}else 
{
    googleMapController?.animateCamera(CameraUpdate.newLatLng(
    LatLng(LocationData.latitude!, LocationData.longitude!)));
}
  }

  void setMyLocationMarker(LocationData LocationData) {
    var myLocationMarker = Marker(markerId: MarkerId('my_location_marker'),
                position: LatLng(LocationData.latitude!, LocationData.longitude!)
                );
    
                 markers.add(myLocationMarker);
                setState(() {
                   
                });
  }

  }

  
//   Future<Uint8List> getImageFromRawData (String image, double width)async
// {
//   var imageData = await rootBundle.load(image);
//  var imageCodec = await ui.instantiateImageCodec(
//   imageData.buffer.asUint8List(), 
//   targetWidth: width.round());

//  var imageFrameInfo = await imageCodec.getNextFrame();

//  var imageByteData =
//   await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

//   return imageByteData!.buffer.asUint8List();
// }


// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20



// inquire about location service
// request permission 
// get location 
// display 