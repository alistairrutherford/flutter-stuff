import 'dart:convert';
import 'dart:io';

import 'package:process_stations/stations.dart';

class StationService {

  /// Read stations
  Future<List<Station?>?> readStations(String filePath) async {
    ReferenceData referenceData = ReferenceData();

    var input = await File(filePath).readAsString();

    var map = jsonDecode(input);

    referenceData.fromJson(map);

    List<Station?>? stations = referenceData.stationsReferenceData!.station;

    return stations;
  }

  /// Filter out invalid stations.
  List<Station?>? filterStations(List<Station?>? data) {
    List<Station?>? filteredList =
        data!.where((o) => o!.tiploc!.isNotEmpty).toList();

    return filteredList;
  }

  /// Write filtered stations back.
  void writeStations(String filePath, List<Station?>? stations) {
    String json = jsonEncode(stations);

    File(filePath).writeAsString(json);
  }
}
