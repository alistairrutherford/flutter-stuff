import 'dart:convert';
import 'dart:io';


class StationService {

  Future<List<Map>> readStations(String filePath) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    return map['stations'];
  }

  List<Map> filterStations(List<Map> data) {
    return data;
  }

  void writeStations(String filePath, List<Map> stations) {

  }
}