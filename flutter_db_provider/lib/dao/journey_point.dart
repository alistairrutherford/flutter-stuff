import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class JourneyPoint {
  int? id;
  final int journey;
  final Position position;

  JourneyPoint({this.id, required this.journey, required this.position});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> jsonMap = position.toJson();
    var jsonStr = json.encode(jsonMap);

    return {
      'id': id,
      'journey': journey,
      'position': jsonStr,
    };
  }

  @override
  String toString() {
    return 'JourneyPoint{id: $id, route: $journey, position: ${position.toString()}';
  }
}
