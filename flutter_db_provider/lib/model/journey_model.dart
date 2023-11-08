import 'package:flutter/material.dart';
import 'package:flutter_db_provider/dao/journey.dart';
import 'package:flutter_db_provider/dao/db_service.dart';
import 'package:flutter_db_provider/dao/journey_point.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class JourneyModel extends ChangeNotifier {
  final _database = DBService();
  final distance = const Distance();

  Position? _lastPosition;

  List<Journey> _journeys = [];

  JourneyModel() {
    // Test Database.
    _database.initialise();
  }

  /// Add new ourney
  ///
  /// - note ID increments
  ///
  /// returns New Journey with populated id.
  Future<Journey> addJourney() async {
    Journey journey =
        Journey(journeyType: JourneyType.commute, startTime: DateTime.now(), distance: 0, uploaded: false);

    // Reset last position for calculating distance.
    _lastPosition = null;

    // Store new journey
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

  /// Update Journey
  ///
  Future<int> updateJourney(Journey journey) async {
    int changes = await _database.updateJourney(journey);

    // Update local list from db.
    _database.getJourneys().then((c) {
      _journeys = c;
      notifyListeners();
    });

    return changes;
  }

  /// Add Point to specified Journey.
  ///
  void addJourneyPoint(Journey journey, Position position) {
    // No need to notify listeners
    JourneyPoint journeyPoint = JourneyPoint(
      journey: journey.id!,
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: position.timestamp!,
      accuracy: position.accuracy,
      altitude: position.altitude,
      altitudeAccuracy: position.altitudeAccuracy,
      heading: position.heading,
      headingAccuracy: position.headingAccuracy,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
    );

    // Update distance
    if (_lastPosition != null) {
      // Calculate distance and update journey
      double distanceKm = distance.as(
          LengthUnit.Kilometer,
          LatLng(_lastPosition!.latitude, _lastPosition!.longitude),
          LatLng(position.latitude, position.longitude));
      journey.distance += distanceKm;
      updateJourney(journey);
    }
    _lastPosition = position;
    _database.insertJourneyPoint(journeyPoint);
  }

  /// Get All Journey Points for supplied Journey.
  ///
  Future<List<LatLng>> getJourneyPoints(int journeyId) async {
    List<LatLng> points = List.empty(growable: true);

    List<JourneyPoint> journeyPoints =
        await _database.getJourneyPoints(journeyId);
    for (JourneyPoint point in journeyPoints) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    return points;
  }

  /// Remove all data.
  ///
  void removeAll() {
    _journeys.clear();
    _database.deleteAll();
    notifyListeners();
  }

  /// Refresh local Journey list.
  ///
  void refresh() {
    _database.getJourneys().then((c) {
      _journeys = c;
      notifyListeners();
    });
  }

  /// Return local Journey list.
  ///
  List<Journey> journeys() {
    return _journeys;
  }
}
