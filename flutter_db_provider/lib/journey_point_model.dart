import 'package:flutter/material.dart';

import 'dao/journey_point.dart';
import 'package:flutter_db_provider/dao/db_service.dart';
import 'package:geolocator/geolocator.dart';

class JourneyPointModel extends ChangeNotifier {
  final _database = DBService();

  List<JourneyPoint> _journeyPoints = [];

  JourneyPointModel() {
    // Test Database.
    _database.initialise();
  }

  /**
   *  Position position = Position(
      longitude: 0.0,
      latitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 60,
      speedAccuracy: 0.0);
   */
  void addPoint(Position position) {
    JourneyPoint location = JourneyPoint(journey: 0, position: position);

    _database.insertJourneyPoint(location);

    _database.getJourneyPoints(0).then((c) {
      _journeyPoints = c;
      notifyListeners();
    });
  }

  void removeAll() {
    _database.deleteAll();
    _journeyPoints.clear();
    notifyListeners();
  }

  List<JourneyPoint> locations() {
    return _journeyPoints;
  }
}