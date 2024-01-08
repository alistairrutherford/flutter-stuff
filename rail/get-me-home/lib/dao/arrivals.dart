
import 'callingpoint.dart';

class Arrivals {
  List<TrainService?>? trainServices;
  Xmlns? xmlns;
  DateTime? generatedAt;
  String? locationName;
  String? crs;
  String? filterType;
  bool? platformAvailable;
  bool? areServicesAvailable;

  Arrivals({this.trainServices, this.xmlns, this.generatedAt, this.locationName, this.crs, this.filterType, this.platformAvailable, this.areServicesAvailable});

  Arrivals.fromJson(Map<String, dynamic> json) {
    if (json['trainServices'] != null) {
      trainServices = <TrainService>[];
      json['trainServices'].forEach((v) {
        trainServices!.add(TrainService.fromJson(v));
      });
    }
    xmlns = json['Xmlns'] != null ? Xmlns?.fromJson(json['Xmlns']) : null;
    generatedAt = json['generatedAt'];
    locationName = json['locationName'];
    crs = json['crs'];
    filterType = json['filterType'];
    platformAvailable = json['platformAvailable'];
    areServicesAvailable = json['areServicesAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['trainServices'] =trainServices != null ? trainServices!.map((v) => v?.toJson()).toList() : null;
    data['Xmlns'] = xmlns!.toJson();
    data['generatedAt'] = generatedAt;
    data['locationName'] = locationName;
    data['crs'] = crs;
    data['filterType'] = filterType;
    data['platformAvailable'] = platformAvailable;
    data['areServicesAvailable'] = areServicesAvailable;
    return data;
  }
}

