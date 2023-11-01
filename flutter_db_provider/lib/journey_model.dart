import 'package:flutter/material.dart';
import 'package:flutter_db_provider/dao/journey.dart';
import 'package:flutter_db_provider/dao/db_service.dart';
import 'package:flutter_db_provider/dao/journey_point.dart';
import 'package:geolocator/geolocator.dart';

class JourneyModel extends ChangeNotifier {
  final _database = DBService();

  List<Journey> _journeys = [];
  List<JourneyPoint> _journeyPoints = [];

  JourneyModel() {
    // Test Database.
    _database.initialise();
  }

  /// Add dummy journey - note ID increments
  Future<Journey> addJourney()  async {
    Journey journey = Journey(journeyType: JourneyType.commute, startTime: DateTime.now());

    int id = await _database.insertJourney(journey);

    // Fetch newly inserted journey.
    journey = await _database.getJourney(id);

    // Update local list from db.
    _database.getJourneys().then((c) {
      _journeys = c;
      notifyListeners();
    });

    return journey;
  }

  Future<int> updateJourney(Journey journey)  async {
    int changes = await _database.updateJourney(journey);

    // Update local list from db.
    _database.getJourneys().then((c) {
      _journeys = c;
      notifyListeners();
    });

    return changes;
  }

  void addJourneyPoint(Journey journey, Position position) {
    // No need to notify listeners
    JourneyPoint journeyPoint = JourneyPoint(journey: journey.id!, position: position);
    _database.insertJourneyPoint(journeyPoint);
  }


  void removeAll() {
    _journeys.clear();
    _database.deleteAll();
    notifyListeners();
  }

  void refresh() {
    _database.getJourneys().then((c) {
      _journeys = c;
      notifyListeners();
    });
  }

  List<Journey> journeys() { return _journeys; }
}