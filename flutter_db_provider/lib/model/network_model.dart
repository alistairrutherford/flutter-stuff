import 'dart:collection';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../dao/db_service.dart';
import '../dao/journey.dart';
import '../dao/journey_point.dart';

/// This provider model handle sending journey data to server.
class NetworkService extends ChangeNotifier {
  // TODO: Could maybe persist this and make it configurable.
  static const String HOST_ENDPOINT = "http://localost:8080/journey";

  late RestartableTimer _periodicTimer;

  final _database = DBService();
  bool processing = false;

  NetworkService() {
    // One-shot restartable timer.
    _periodicTimer = RestartableTimer(
      const Duration(seconds: 5),
      () {
        if (!processing) {
          process();
        }
      },
    );
    _periodicTimer.cancel();
  }

  void process() async {
    processing = true;

    // Select oldest journey which has not been uploaded

    // Fetch journey record
    int id = -1;
    Journey journey = await _database.getJourney(id);

    // Fetch journey points
    List<JourneyPoint> journeyPoints =  await _database.getJourneyPoints(id);

    // Post to server
    if (journeyPoints.isNotEmpty) {
      await postJourney(journey, journeyPoints);

      // Update journey to mark it as uploaded.
      journey.uploaded = true;
      _database.updateJourney(journey);
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
      Uri.parse(HOST_ENDPOINT),
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
