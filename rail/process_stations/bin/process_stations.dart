import 'dart:developer';
import 'dart:io';
import 'package:process_stations/station_service.dart';

const String INPUT_DATA = "stations.json";

String buildFilePath(String fileName) {
  Directory current = Directory.current;

  String path = current.toString().split(' ')[1].replaceAll('\'','') + "/data/" + fileName;

  return path;
}

void main(List<String> arguments) {
 StationService service = StationService();

 String filePath = buildFilePath(INPUT_DATA);

 log(filePath);

  // TODO read stations data, filter and write back.
}
