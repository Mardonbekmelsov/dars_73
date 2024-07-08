import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_73/services/location_firebase_services.dart';
import 'package:flutter/material.dart';

class LocationController with ChangeNotifier {
  final _locationFirebaseService = LocationFirebaseServices();

  Stream<QuerySnapshot> get list async* {
    yield* _locationFirebaseService.getLocation();
  }

  Future<void> addLocation(String title, File? imageFile, List location) async {
    await _locationFirebaseService.addLocation(title, imageFile, location);
  }

  Future<void> editLocation(String id, String title, File? imageFile) async {
    await _locationFirebaseService.editLocation(id, title, imageFile);
  }

  Future<void> deleteLocation(String id) async {
    await _locationFirebaseService.deleteLocation(id);
  }
}