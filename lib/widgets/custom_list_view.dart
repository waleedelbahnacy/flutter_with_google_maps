
import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:flutter_with_google_maps/models/place_details_model/place_details_model.dart';
import 'package:flutter_with_google_maps/utils/google_maps_place_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places, required this.googleMapsPlaceService, required this.onPlaceSelect,
  });

  final List<PlaceModel> places;
  final void Function(PlaceDetailsModel) onPlaceSelect;
 final GoogleMapsPlaceService googleMapsPlaceService;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context,index)
      {
        return ListTile(
          leading:const Icon(FontAwesomeIcons.mapPin) ,
          title: Text(
            places[index].description!),
            trailing: IconButton(
              onPressed: ()async
              {
          var placeDetails =  await googleMapsPlaceService
          .getPlaceDetails(placeid: places[index].placeId.toString());
        onPlaceSelect(placeDetails);

              },
               icon:const Icon( Icons.arrow_circle_right_outlined)),
        );
      }, separatorBuilder: (context,index)
      {
        return const Divider(
          height: 0,
        );
      }
      , itemCount: places.length),
    );
  }
}
