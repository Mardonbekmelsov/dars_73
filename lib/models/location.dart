import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  String id;
  String title;
  String? imageUrl;
  List location;
  Location({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
  });


  
  factory Location.fromJson(QueryDocumentSnapshot query) {
    final data = query.data() as Map<String, dynamic>;
    return Location(
      id: query.id,
      title: query['title'],
      imageUrl: data.containsKey('imageUrl') ? data['imageUrl'] : null,
      location: query['location'],
    );
  }
}