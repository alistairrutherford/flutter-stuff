import 'dart:developer';
import 'dart:io';
import 'package:process_stations/station_service.dart';
import 'package:process_stations/stations.dart';

const String INPUT_DATA = "stations.json";
const String OUTPUT_DATA = "filtered.json";

String buildFilePath(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'', '') +
      "/assets/" +
      fileName;

  return path;
}

Future<void> main(List<String> arguments) async {
  StationService service = StationService();

  String filePath = buildFilePath(INPUT_DATA);

  print("Filepath: $filePath");

  // read stations data, filter and write back.
  List<Station?>? stationsdata = await service.readStations(filePath);

  // read stations data, filter and write back.
  List<Station?>? filteredStation = service.filterStations(stationsdata);

  String outPath = buildFilePath(OUTPUT_DATA);

  service.writeStations(outPath, filteredStation);

}
