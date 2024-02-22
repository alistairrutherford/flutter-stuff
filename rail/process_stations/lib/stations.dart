import "parse_helper.dart";

/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class ReferenceData {
  StationsReferenceData? stationsReferenceData;

  ReferenceData({this.stationsReferenceData});

  fromJson(Map<String, dynamic> json) {
    stationsReferenceData = json['StationsReferenceData'] != null ? StationsReferenceData?.fromJson(json['StationsReferenceData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['StationsReferenceData'] = stationsReferenceData!.toJson();
    return data;
  }
}

class Station {
  String? nlc;
  String? name;
  String? tiploc;
  String? cRS;
  bool? oJPEnabled;
  String? oJPDisplayName;
  String? oJPAdviceMessage;
  String? rSPDisplayName;
  bool? attendedTIS;
  bool? unattendedTIS;

  Station({this.nlc, this.name, this.tiploc, this.cRS, this.oJPEnabled, this.oJPDisplayName, this.oJPAdviceMessage, this.rSPDisplayName, this.attendedTIS, this.unattendedTIS});

  Station.fromJson(Map<String, dynamic> json) {
    try {
      nlc = ParserHelper.parseIntString(json, 'Nlc');

      name = json['Name'];
      tiploc = json['Tiploc'];
      cRS = json['CRS'];
      oJPEnabled = json['OJPEnabled'];
      oJPDisplayName = json['OJPDisplayName'];
      oJPAdviceMessage = json['OJPAdviceMessage'];
      rSPDisplayName = json['RSPDisplayName'];
      attendedTIS = json['AttendedTIS'];
      unattendedTIS = json['UnattendedTIS'];
    } catch(e) {
      print(e);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Nlc'] = nlc;
    data['Name'] = name;
    data['Tiploc'] = tiploc;
    data['CRS'] = cRS;
    data['OJPEnabled'] = oJPEnabled;
    data['OJPDisplayName'] = oJPDisplayName;
    data['OJPAdviceMessage'] = oJPAdviceMessage;
    data['RSPDisplayName'] = rSPDisplayName;
    data['AttendedTIS'] = attendedTIS;
    data['UnattendedTIS'] = unattendedTIS;
    return data;
  }
}

class StationsReferenceData {
  List<Station?>? station;

  StationsReferenceData({this.station});

  StationsReferenceData.fromJson(Map<String, dynamic> json) {
    if (json['Station'] != null) {
      station = <Station>[];
      json['Station'].forEach((v) {
        station!.add(Station.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Station'] =Station != null ? station!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

