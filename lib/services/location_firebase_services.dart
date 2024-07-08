import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class LocationFirebaseServices {
  final _locationCollection = FirebaseFirestore.instance.collection("location");
  final _locationImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getLocation() async* {
    yield* _locationCollection.snapshots();
  }

  Future<void> addLocation(String title, File? imageFile, List location) async {
    if (imageFile != null) {
      final imageReference = _locationImageStorage
          .ref()
          .child("location")
          .child("images")
          .child("${UniqueKey()}.jpg");

      final uploadTask = imageReference.putFile(imageFile);

      await uploadTask.whenComplete(() async {
        final imageUrl = await imageReference.getDownloadURL();
        await _locationCollection.add({
          "title": title,
          "imageUrl": imageUrl,
          "location": location,
        });
      });
    } else {
      await _locationCollection.add({
        "title": title,
        "location": location,
      });
    }
  }

  Future<void> editLocation(String id, String title, File? imageFile) async {
    if (imageFile != null) {
      final imageReference = _locationImageStorage
          .ref()
          .child("location")
          .child("images")
          .child("${UniqueKey()}.jpg");

      final uploadTask = imageReference.putFile(imageFile);

      await uploadTask.whenComplete(() async {
        final imageUrl = await imageReference.getDownloadURL();
        await _locationCollection.doc(id).update({
          "title": title,
          "imageUrl": imageUrl,
        });
      });
    } else {
      await _locationCollection.doc(id).update({
        "title": title,
      });
    }
  }

  Future<void> deleteLocation(String id) async {
    _locationCollection.doc(id).delete();
  }
}