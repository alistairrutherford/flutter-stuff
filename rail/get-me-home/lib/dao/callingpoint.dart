/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class CallingPoint {
  String? locationName;
  String? crs;
  String? st;
  String? et;
  bool? isCancelled;
  int? length;
  bool? detachFront;
  bool? affectedByDiversion;
  int? rerouteDelay;

  CallingPoint({this.locationName, this.crs, this.st, this.et, this.isCancelled, this.length, this.detachFront, this.affectedByDiversion, this.rerouteDelay});

  CallingPoint.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    crs = json['crs'];
    st = json['st'];
    et = json['et'];
    isCancelled = json['isCancelled'];
    length = json['length'];
    detachFront = json['detachFront'];
    affectedByDiversion = json['affectedByDiversion'];
    rerouteDelay = json['rerouteDelay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['locationName'] = locationName;
    data['crs'] = crs;
    data['st'] = st;
    data['et'] = et;
    data['isCancelled'] = isCancelled;
    data['length'] = length;
    data['detachFront'] = detachFront;
    data['affectedByDiversion'] = affectedByDiversion;
    data['rerouteDelay'] = rerouteDelay;
    return data;
  }
}

class Destination {
  String? locationName;
  String? crs;
  bool? assocIsCancelled;

  Destination({this.locationName, this.crs, this.assocIsCancelled});

  Destination.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    crs = json['crs'];
    assocIsCancelled = json['assocIsCancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['locationName'] = locationName;
    data['crs'] = crs;
    data['assocIsCancelled'] = assocIsCancelled;
    return data;
  }
}

class Origin {
  String? locationName;
  String? crs;
  bool? assocIsCancelled;

  Origin({this.locationName, this.crs, this.assocIsCancelled});

  Origin.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    crs = json['crs'];
    assocIsCancelled = json['assocIsCancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['locationName'] = locationName;
    data['crs'] = crs;
    data['assocIsCancelled'] = assocIsCancelled;
    return data;
  }
}


class SubsequentCallingPoint {
  List<CallingPoint?>? callingPoint;
  String? serviceType;
  bool? serviceChangeRequired;
  bool? assocIsCancelled;

  SubsequentCallingPoint({this.callingPoint, this.serviceType, this.serviceChangeRequired, this.assocIsCancelled});

  SubsequentCallingPoint.fromJson(Map<String, dynamic> json) {
    if (json['callingPoint'] != null) {
      callingPoint = <CallingPoint>[];
      json['callingPoint'].forEach((v) {
        callingPoint!.add(CallingPoint.fromJson(v));
      });
    }
    serviceType = json['serviceType'];
    serviceChangeRequired = json['serviceChangeRequired'];
    assocIsCancelled = json['assocIsCancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['callingPoint'] =callingPoint != null ? callingPoint!.map((v) => v?.toJson()).toList() : null;
    data['serviceType'] = serviceType;
    data['serviceChangeRequired'] = serviceChangeRequired;
    data['assocIsCancelled'] = assocIsCancelled;
    return data;
  }
}

class TrainService {
  List<SubsequentCallingPoint?>? subsequentCallingPoints;
  bool? futureCancellation;
  bool? futureDelay;
  List<Origin?>? origin;
  List<Destination?>? destination;
  String? std;
  String? etd;
  String? platform;
  String? operator;
  String? operatorCode;
  bool? isCircularRoute;
  bool? isCancelled;
  bool? filterLocationCancelled;
  String? serviceType;
  int? length;
  bool? detachFront;
  bool? isReverseFormation;
  String? serviceID;

  TrainService({this.subsequentCallingPoints, this.futureCancellation, this.futureDelay, this.origin, this.destination, this.std, this.etd, this.platform, this.operator, this.operatorCode, this.isCircularRoute, this.isCancelled, this.filterLocationCancelled, this.serviceType, this.length, this.detachFront, this.isReverseFormation, this.serviceID});

  TrainService.fromJson(Map<String, dynamic> json) {
    if (json['subsequentCallingPoints'] != null) {
      subsequentCallingPoints = <SubsequentCallingPoint>[];
      json['subsequentCallingPoints'].forEach((v) {
        subsequentCallingPoints!.add(SubsequentCallingPoint.fromJson(v));
      });
    }
    futureCancellation = json['futureCancellation'];
    futureDelay = json['futureDelay'];
    if (json['origin'] != null) {
      origin = <Origin>[];
      json['origin'].forEach((v) {
        origin!.add(Origin.fromJson(v));
      });
    }
    if (json['destination'] != null) {
      destination = <Destination>[];
      json['destination'].forEach((v) {
        destination!.add(Destination.fromJson(v));
      });
    }
    std = json['std'];
    etd = json['etd'];
    platform = json['platform'];
    operator = json['operator'];
    operatorCode = json['operatorCode'];
    isCircularRoute = json['isCircularRoute'];
    isCancelled = json['isCancelled'];
    filterLocationCancelled = json['filterLocationCancelled'];
    serviceType = json['serviceType'];
    length = json['length'];
    detachFront = json['detachFront'];
    isReverseFormation = json['isReverseFormation'];
    serviceID = json['serviceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subsequentCallingPoints'] =subsequentCallingPoints != null ? subsequentCallingPoints!.map((v) => v?.toJson()).toList() : null;
    data['futureCancellation'] = futureCancellation;
    data['futureDelay'] = futureDelay;
    data['origin'] =origin != null ? origin!.map((v) => v?.toJson()).toList() : null;
    data['destination'] =destination != null ? destination!.map((v) => v?.toJson()).toList() : null;
    data['std'] = std;
    data['etd'] = etd;
    data['sta'] = std;
    data['eta'] = etd;
    data['platform'] = platform;
    data['operator'] = operator;
    data['operatorCode'] = operatorCode;
    data['isCircularRoute'] = isCircularRoute;
    data['isCancelled'] = isCancelled;
    data['filterLocationCancelled'] = filterLocationCancelled;
    data['serviceType'] = serviceType;
    data['length'] = length;
    data['detachFront'] = detachFront;
    data['isReverseFormation'] = isReverseFormation;
    data['serviceID'] = serviceID;
    return data;
  }
}

class Xmlns {
  int? count;

  Xmlns({this.count});

  Xmlns.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Count'] = count;
    return data;
  }
}
