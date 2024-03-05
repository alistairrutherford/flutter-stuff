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

  /// TODO Rerwrite this
  String getStationName(int index) {
    String name = "";

    if (stations != null) {
      if (stations!.stationsReferenceData != null) {
        if (stations!.stationsReferenceData!.station != null) {
          name = stations!.stationsReferenceData!.station![index]!.name!;
        }
      }
    }

    return name;
  }

  /// TODO Rerwrite this
  int stationsCount(StationsModel model) {
    int count = 0;

    if (stations != null) {
      if (stations!.stationsReferenceData != null) {
        if (stations!.stationsReferenceData!.station != null) {
          count = stations!.stationsReferenceData!.station!.length;
        }
      }
    }

    return count;
  }
}
