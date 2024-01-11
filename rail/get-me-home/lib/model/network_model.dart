import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_me_home/dao/arrivals.dart';
import 'package:get_me_home/dao/departures.dart';
import 'package:get_me_home/model/prefs_model.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:http/http.dart' as http;

/// This provider model handle sending journey data to server.
class NetworkModel extends ChangeNotifier {
  // TODO: Could maybe persist this and make it configurable.
  static const int timerPeriod = 60;

  final _sharedPreferences = SharedPreferencesModel();

  late RestartableTimer _periodicTimer;
  bool processing = false;
  String? hostEndpoint;


  void onInit(TimeTableModel timeTableModel) {
    hostEndpoint = _sharedPreferences.arrivalsURL;

    // One-shot restartable timer.
    _periodicTimer = RestartableTimer(
      const Duration(seconds: timerPeriod),
      () {
        // Only process if we are not already processing.
        if (!processing) {
          process(timeTableModel);
        }
        _periodicTimer.reset(); // Keep going.
      },
    );
  }

  void process(TimeTableModel timeTableModel) async {
    processing = true;

    timeTableModel.refresh(this);

    // processing has completed
    processing = false;
  }

  Future<List<Arrivals>> getArrivals() async {
    final response = await http.get(
        Uri.parse(_sharedPreferences.arrivalsURL!),
        headers: {'x-apikey': _sharedPreferences.apiKey!}
    );

    var data = jsonDecode(response.body.toString());

    List<Arrivals> arrivals = List.empty(growable: true);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        arrivals.add(Arrivals.fromJson(index));
      }
      return arrivals;
    }
    return arrivals; //empty list
  }

  Future<List<Departures>> getDepartures() async {
    final response = await http.get(
        Uri.parse(_sharedPreferences.departuresURL!),
        headers: {'x-apikey': _sharedPreferences.apiKey!}
    );

    var data = jsonDecode(response.body.toString());

    List<Departures> departures = List.empty(growable: true);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        departures.add(Departures.fromJson(index));
      }
      return departures;
    }
    return departures; //empty list
  }
}
