import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../dao/stations.dart';
import '../main.dart';

/// Implement fetching data.
class StationsModel extends ChangeNotifier {
  ReferenceData? stations;
  List<DropdownMenuEntry<IconLabel>> dropdownStations = List<DropdownMenuEntry<IconLabel>>.empty(growable: true);

  /// Chain the initialise.
  Future<void> initialise() async {
    // Do await.
    await loadStations();

    // Build station dropdown list.
    buildStationsMenu();
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

  /// Build dropdown list.
  List<DropdownMenuEntry<IconLabel>> buildStationsMenu() {

    if (stations != null) {
      if (stations!.stationsReferenceData != null) {
        if (stations!.stationsReferenceData!.station != null) {
          var allStations = stations!.stationsReferenceData!.station;

          for (final station in allStations!) {
            String name = station!.name!;
            IconLabel iconLabel = IconLabel(name, Icons.favorite);

            DropdownMenuEntry<IconLabel> entry = DropdownMenuEntry<IconLabel>(value: iconLabel, label: name);

            dropdownStations.add(entry);
          }
        }
      }
    }

    return dropdownStations;
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
