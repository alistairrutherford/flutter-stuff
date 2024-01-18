import 'package:flutter/material.dart';

import '../dao/arrivals.dart';
import '../dao/callingpoint.dart';
import '../dao/departures.dart';
import 'network_model.dart';

class TrainServiceDetails {
  String origin = "";
  String destination = "";
  String arrival = "";
  String eta = "";
}

class TimeTableModel extends ChangeNotifier {

  List<TrainService?> arrivals = [];
  List<TrainService?> departures = [];
  TrainServiceDetails arrivalTrainServiceDetails = TrainServiceDetails();
  TrainServiceDetails departureTrainServiceDetails = TrainServiceDetails();

  NetworkModel? _networkModel;

  void initialise(NetworkModel networkModel) {
    _networkModel = networkModel;
    networkModel.initialise(onInit);
  }

  void onInit() {
    refresh();
  }

  /// Extract train service detail fields.
  void populateTrainServiceDetails(TrainService trainService, TrainServiceDetails trainServiceDetails) {
    Origin? origin = trainService.origin![0];
    trainServiceDetails.origin = origin!.locationName!;
    Destination? destination = trainService.destination![0];
    trainServiceDetails.destination = destination!.locationName!;
  }

  /// Refresh local Journey list.
  ///
  void refresh() {
    _networkModel!.getArrivals().then((c) {
      arrivals = c;
      if (arrivals.isNotEmpty) {
        TrainService? trainService = arrivals[0];
        populateTrainServiceDetails(trainService!, arrivalTrainServiceDetails);
      }
      notifyListeners();
    });
    _networkModel!.getDepartures().then((c) {
      departures = c;
      if (departures.isNotEmpty) {
        TrainService? trainService = departures[0];
        populateTrainServiceDetails(trainService!, departureTrainServiceDetails);
      }
      notifyListeners();
    });
  }
}