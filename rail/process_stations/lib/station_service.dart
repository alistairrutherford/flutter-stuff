import 'dart:convert';
import 'dart:io';

import 'package:process_stations/stations.dart';


class StationService {

  Future<List<Map>> readStations(String filePath) async {
    ReferenceData referenceData = ReferenceData();

    var input = await File(filePath).readAsString();

    var map = jsonDecode(input);

    referenceData.fromJson(map);

    return map['Station'];
  }

  List<Map> filterStations(List<Map> data) {
    return data;
  }

  void writeStations(String filePath, List<Map> stations) {

  }
}