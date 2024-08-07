import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_with_google_maps/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:flutter_with_google_maps/models/place_details_model/place_details_model.dart';
import 'package:flutter_with_google_maps/utils/google_maps_place_service.dart';
import 'package:flutter_with_google_maps/utils/location_service.dart';
import 'package:flutter_with_google_maps/widgets/custom_list_view.dart';
import 'package:flutter_with_google_maps/widgets/custom_text_field.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;

import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
 late CameraPosition initialCameraPosition;
 late GoogleMapsPlaceService googleMapsPlaceService;
 late LocationService locationService;
 late TextEditingController textEditingController;
 late GoogleMapController googleMapController;
 String? sessionToken;
 late Uuid uuid;
 Set<Marker> markers ={};

 List<PlaceModel> places = [];
 @override
  void initState() {
    uuid =Uuid();
    googleMapsPlaceService = GoogleMapsPlaceService();
    textEditingController = TextEditingController();
    initialCameraPosition = const CameraPosition(
      zoom : 1,
      target: LatLng(0,0));
     
     locationService = LocationService();
    updateCurrentLocation();
    fetchPredictions();
    super.initState();
  }

 void fetchPredictions() {
    textEditingController.addListener(()async
   {
     sessionToken ??= uuid.v4();
     print(sessionToken);
     if (textEditingController.text.isNotEmpty) {
  var result = await  googleMapsPlaceService.getPredictions(
    sessionToken: sessionToken!,
    input: textEditingController.text);
  places.clear();
places.addAll(result);
setState(() {
  
});
}else
{
  places.clear();
  setState(() {
    
  });
} 

   });
 }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
        updateCurrentLocation();
        
          },
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition
        ),
         Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: textEditingController,
              ),
              SizedBox(
                height: 16,
              ),
                CustomListView(
                  onPlaceSelect: (PlaceDetailsModel)
                  {
                    textEditingController.clear();
                    places.clear();
                       
                  sessionToken = null;
                    setState(() {
                      
                    });
                  },
                  places: places,
                googleMapsPlaceService: googleMapsPlaceService,
                ),
          
            ],
          ),
          ),
      ],
    );
  }
  
  void updateCurrentLocation() async
  {
   try {
  var locationData = await  locationService.getLocation();
  LatLng currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
  Marker currentLocationMarker = Marker(markerId: MarkerId('my location'),
  position: currentPosition,
  );
  CameraPosition myCurrentCameraPosition = CameraPosition(target: currentPosition,
   zoom: 16,
   );
  googleMapController.animateCamera(CameraUpdate.newCameraPosition(myCurrentCameraPosition));
  markers.add(currentLocationMarker);
  setState(() {
    
  });
} on LocationServiceException catch (e) {
  // TODO :
} on LocationPermissionException catch (e)
 {
  //TODO :
 }catch (e)
 {
  //ToDO :
 }
  }
 

  }


  // text field => search place 
  // create route  