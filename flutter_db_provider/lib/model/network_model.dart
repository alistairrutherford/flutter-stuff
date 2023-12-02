import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../dao/db_service.dart';
import '../dao/journey.dart';
import '../dao/journey_point.dart';

/// This provider model handle sending journey data to server.
class NetworkModel extends ChangeNotifier {
  // TODO: Could maybe persist this and make it configurable.
  static const String hostEndPoint = "http://10.0.2.2:8080/journeyrec/journey";
  static const int timerPeriod = 5;

  late RestartableTimer _periodicTimer;

  final _database = DBService();
  bool processing = false;

  NetworkModel() {
    _database.initialise(onInit);
  }

  /// This is called when database has been initialised.
  ///
  void onInit() {
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

    // We always fetch only the oldest not uploaded journey,
    if (ids.length == 1) {
      int id = ids[0];
      // Fetch journey record
      Journey journey = await _database.getJourney(id);

      // Fetch journey points
      List<JourneyPoint> journeyPoints = await _database.getJourneyPoints(id);

      // Post to server
      if (journeyPoints.isNotEmpty) {
          postJourney(journey, journeyPoints).then((code) {
            var response = code;
            if (response.statusCode == 200) {
              // Update journey to mark it as uploaded.
              journey.uploaded = false; // TODO revert to true.
              _database.updateJourney(journey).then((c) {
                // Notify UI to indicate journey uploaded.
                notifyListeners();
              });
            }
          }).catchError((error) {
            // Catch asynchronous error
            stderr.writeln(error);
          });
        }
      }

    // Signal processing has completed
    processing = false;
  }

  /// Post journey data to server
  Future<http.Response> postJourney(
      Journey journey, List<JourneyPoint> journeyPoints) {
    String encodedJourney = jsonEncode(<String, String>{
      'journey': journey.toMap().toString(),
      'points': journeyPoints.toString()
    });

    var response = http.post(
      Uri.parse(hostEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: encodedJourney,
    );

    return response;
  }
}
