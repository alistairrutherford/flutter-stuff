import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../dao/arrivals.dart';
import '../dao/callingpoint.dart';
import '../dao/departures.dart';
import 'network_model.dart';

class TrainServiceDetails {
  String origin = "---";
  String destination = "---";
  String arrival = "---";
  String eta = "---";
}

class TimeTableModel extends ChangeNotifier {
  static const int timerPeriod = 1;
  bool processing = true;
  late RestartableTimer _periodicTimer;

  List<TrainService?> trainServices = [];

  TrainServiceDetails arrivalTrainServiceDetails = TrainServiceDetails();
  TrainServiceDetails departureTrainServiceDetails = TrainServiceDetails();

  NetworkModel? _networkModel;

  void initialise(NetworkModel networkModel) {
    _networkModel = networkModel;
    networkModel.initialise(onInit);
  }

  void onInit() {

    _periodicTimer = RestartableTimer(
      const Duration(minutes: timerPeriod),
          () {
        // Only process if we are not already processing.
        if (processing) {
         refresh();
        }
        _periodicTimer.reset(); // Keep going.
      },
    );

    refresh();
  }

  /// Extract train service detail fields.
  void populateTrainServiceDetails(TrainService trainService, TrainServiceDetails trainServiceDetails) {
    Origin? origin = trainService.origin![0];
    trainServiceDetails.origin = origin!.locationName ?? "---";
    Destination? destination = trainService.destination![0];
    trainServiceDetails.destination = destination!.locationName ?? "---";
    String? arrival = trainService.sta ?? trainService.std;
    String? eta = trainService.eta ?? trainService.etd;
    arrival = arrival ?? "---";
    eta = eta ?? "---";
    trainServiceDetails.arrival = arrival;
    trainServiceDetails.eta = eta;
  }

  /// Refresh local Journey list.
  ///
  void refresh() {
    Arrivals? arrivals = Arrivals(locationName: "----");
    Departures? departures = Departures(locationName: "----");

    _networkModel!.getArrivals().then((c) {
      arrivals = c;
      if (arrivals != null) {
        TrainService? trainService = arrivals!.trainServices![0];
        populateTrainServiceDetails(trainService!, arrivalTrainServiceDetails);
        trainServices.add(trainService);
        notifyListeners();
      }
    });

    _networkModel!.getDepartures().then((c) {
      departures = c;
      if (departures != null) {
        TrainService? trainService = departures!.trainServices![0];
        populateTrainServiceDetails(trainService!, departureTrainServiceDetails);
        trainServices.add(trainService);
        notifyListeners();
      }
    });

    // Process arrivals and departures for relevant service data

    // For each trainservice in arrivals or departures extract the closest to
    // time now for each possible platform

  }
}