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
  final _sharedPreferences = SharedPreferencesModel();

  Function? onInit;

  ReferenceData? stations;

  /// Chain the initialise.
  void initialise(Function onInit) async {
    this.onInit = onInit;

    // Do await.
    await loadStations();

    // Call callers onInit().
    onInit();
  }

  /// Load station data from JSON
  Future<void> loadStations() async {
    stations = await rootBundle
        .loadStructuredData<ReferenceData>('assets/stations.json', (jsonStr) async {
      final stations = ReferenceData.fromJson(json.decode(jsonStr));
      return stations;
    });
  }

}
