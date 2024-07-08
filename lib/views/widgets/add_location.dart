import 'dart:io';
import 'package:dars_73/controllers/location_controller.dart';
import 'package:dars_73/services/location_service.dart';
import 'package:dars_73/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final titleController = TextEditingController();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await LocationServices.getCurrentLocation();
      setState(() {
        
      });
    });
  }

  void addLocation() async {
    Messages.showLoadingDialog(context);
    await context.read<LocationController>().addLocation(
        titleController.text, imageFile,[LocationServices.currentLocation?.latitude,LocationServices.currentLocation?.longitude]);

    if (context.mounted) {
      titleController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

 

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: const Text("Location Qo'shish"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Location title",
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Rasm Qo'shish",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: openCamera,
                label: const Text("Kamera"),
                icon: const Icon(Icons.camera),
              ),
            ],
          ),
          if (imageFile != null)
            SizedBox(
              height: 200,
              child: Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
            )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor Qilish"),
        ),
        FilledButton(
          onPressed: addLocation,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}