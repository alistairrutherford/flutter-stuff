import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../dao/db_service.dart';
import '../dao/journey.dart';
import '../dao/journey_point.dart';

/// This provider model handle sending journey data to server.
class NetworkModel extends ChangeNotifier {
  // TODO: Could maybe persist this and make it configurable.
  static const String hostEndPoint = "http://localhost:8080/journey";
  static const int timerPeriod = 5;

  late RestartableTimer _periodicTimer;

  final _database = DBService();
  bool processing = false;

  NetworkModel() {
    // One-shot restartable timer.
    _periodicTimer = RestartableTimer(
      const Duration(seconds: timerPeriod),
      () {
        // Only process if we are not already processing.
        if (!processing) {
          process();
        }
        _periodicTimer.reset(); // Keep going.
      },
    );
  }

  void process() async {
    processing = true;

    // Select oldest journey which has not been uploaded
    List<int> ids = await _database.getJourneysToUpload();

    // For each journey to upload.
    for (int id in ids) {
      // Fetch journey record
      Journey journey = await _database.getJourney(id);

      // Fetch journey points
      List<JourneyPoint> journeyPoints = await _database.getJourneyPoints(id);

      // Post to server
      if (journeyPoints.isNotEmpty) {
        await postJourney(journey, journeyPoints);

        // Update journey to mark it as uploaded.
        journey.uploaded = true;
        _database.updateJourney(journey);
      }
    }

    // Signal processing has completed
    processing = false;

    // Notify any listening interface elements.
    notifyListeners();
  }

  /// Post journey data to server
  Future<http.Response> postJourney(
      Journey journey, List<JourneyPoint> journeyPoints) {
    return http.post(
      Uri.parse(hostEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'journey': journey.toMap().toString(),
        'points': jsonEncode(journeyPoints.map((e) => e.toMap()).toList())
      }),
    );
  }
}
