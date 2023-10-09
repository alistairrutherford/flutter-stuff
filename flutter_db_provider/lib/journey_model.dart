import 'package:flutter/material.dart';
import 'package:flutter_db_provider/dao/journey.dart';
import 'package:flutter_db_provider/dao/db_service.dart';

class JourneyModel extends ChangeNotifier {
  static int _nextId = 0;

  final _database = DBService();

  List<Journey> _journeys = [];

  JourneyModel() {
    // Test Database.
    _database.initialise();
  }

  /// Add dummy journey - note ID increments
  Journey addJourney()  {
    Journey journey = Journey(id:_nextId++,  journeyType: JourneyType.commute, startTime: DateTime.now());

    _database.insertJourney(journey);

    _database.getJourneys().then((c) {
      _journeys = c;
      notifyListeners();
    });

    return journey;
  }

  void removeAll() {
    _journeys.clear();
    notifyListeners();
  }

  List<Journey> journeys() { return _journeys; }
}