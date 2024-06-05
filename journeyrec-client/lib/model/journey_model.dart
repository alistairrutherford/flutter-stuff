import 'package:flutter/material.dart';
import 'package:journeyrec_client/dao/journey.dart';
import 'package:journeyrec_client/dao/db_service.dart';
import 'package:journeyrec_client/dao/journey_point.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class JourneyModel extends ChangeNotifier {
  NumberFormat formatter = NumberFormat("00");

  final _database = DBService();
  final distance = const Distance();

  Position? _lastPosition;
  double _distance = 0.0;

  List<Journey> _journeys = [];

  JourneyModel() {
    // Initialise database and provide call back to populate model.
    _database.initialise(onInit);
  }

  /// This is called when database has been initialised.
  ///
  void onInit() {
    refresh();
  }

  /// Add new Journey
  ///
  /// - note ID increments
  /// - We don't need to assign device Id until we post it to server.
  ///
  /// returns New Journey with populated id.
  Future<Journey> addJourney(String deviceId) async {
    Journey journey = Journey(
        deviceId: deviceId,
        journeyType: JourneyType.commute,
        startTime: DateTime.now(),
        duration: 0,
        distance: 0,
        uploaded: false);

    // Reset last position for calculating distance.
    _lastPosition = null;
    _distance = 0.0;

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

  /// This method formats seconds into 00:00:00 form.
  ///
  String formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hour = (timeInSecond / 3600).floor();
    return "${formatter.format(hour)}:${formatter.format(min)}:${formatter.format(sec)}";
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

  /// Update Journey
  ///
  Future<int> deleteJourney(Journey journey) async {
    int changes = await _database.delete(journey);

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
      double distanceM = distance.as(
          LengthUnit.Meter,
          LatLng(_lastPosition!.latitude, _lastPosition!.longitude),
          LatLng(position.latitude, position.longitude));

      // Update distance (m)
      _distance += distanceM;
      // Save distance (km)
      journey.distance = _distance / 1000;
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
