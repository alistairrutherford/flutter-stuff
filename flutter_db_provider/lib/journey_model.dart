import 'package:flutter/material.dart';
import 'package:flutter_db_provider/dao/journey.dart';
import 'package:flutter_db_provider/dao/db_service.dart';

class JourneyModel extends ChangeNotifier {
  final _database = DBService();

  List<Journey> _journeys = [];

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

  void removeAll() {
    _journeys.clear();
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