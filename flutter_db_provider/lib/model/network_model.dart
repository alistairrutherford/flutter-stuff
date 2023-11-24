import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../dao/journey.dart';
import '../dao/journey_point.dart';

/// This provider model will network traffic to server.
class JourneyModel extends ChangeNotifier {

  static const String HOST_ENDPOINT = "http://localost:8080/journey";

  Future<http.Response> postJourney(Journey journey, List<JourneyPoint> journeyPoints) {
    return http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'journey': journey.toMap().toString(),
        'points':journeyPoints
      }),
    );
  }
}