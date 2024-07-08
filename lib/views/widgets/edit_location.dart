import 'dart:io';
import 'package:dars_73/controllers/location_controller.dart';
import 'package:dars_73/models/location.dart';
import 'package:dars_73/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditLocation extends StatefulWidget {
  Location location;
  EditLocation({super.key, required this.location});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final titleController = TextEditingController();
  File? imageFile;

  void editLocation() async {
    print(titleController.text);
    Messages.showLoadingDialog(context);
    await context
        .read<LocationController>()
        .editLocation(widget.location.id, titleController.text, imageFile);

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
  void initState() {
    titleController.text = widget.location.title;
    super.initState();
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
              labelText: "Mahsulot nomi",
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
          onPressed: editLocation,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}