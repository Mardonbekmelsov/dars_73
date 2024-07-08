import 'package:dars_73/controllers/location_controller.dart';
import 'package:dars_73/models/location.dart';
import 'package:dars_73/views/widgets/edit_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationItem extends StatelessWidget {
  final Location location;

  const LocationItem({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Provider.of<LocationController>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(location.imageUrl ??
                    "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ="),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  location.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => EditLocation(location: location),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 30,
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lat: ${location.location[0]}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Long: ${location.location[1]}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  locationController.deleteLocation(location.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
