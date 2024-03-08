import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  /// Extract station name.
  ///
  /// We build JSON to ensure no empty values.
  String getStationName(int index) {
    String name = stations!.stationsReferenceData!.station![index]!.name!;
    return name;
  }

  /// Extract count.
  ///
  /// We build JSON to ensure no empty values.
  int stationsCount(StationsModel model) {
    int count = stations!.stationsReferenceData!.station!.length;
    return count;
  }
}
