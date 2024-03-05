import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_me_home/dao/arrivals.dart';
import 'package:get_me_home/dao/departures.dart';
import 'package:get_me_home/model/prefs_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import '../dao/stations.dart';

/// Implement fetching data.
class StationsModel extends ChangeNotifier {
  ReferenceData? stations;

  /// Chain the initialise.
  Future<void> initialise() async {
    // Do await.
    await loadStations();
  }

  /// Load station data from JSON
  Future<void> loadStations() async {
    stations = await rootBundle
        .loadStructuredData<ReferenceData>('assets/stations.json', (jsonStr) async {
      final stations = ReferenceData.fromJson(json.decode(jsonStr));
      return stations;
    });
    // Notify model subscribers that station loaded.
    notifyListeners();
  }

}
