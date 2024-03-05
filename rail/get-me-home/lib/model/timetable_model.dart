import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../dao/arrivals.dart';
import '../dao/callingpoint.dart';
import '../dao/departures.dart';
import 'network_model.dart';

class TimeTableEntry {
  String locationName;
  TrainService trainService;

  TimeTableEntry(this.locationName, this.trainService);
}

class TimeTableModel extends ChangeNotifier {
  static const int timerPeriod = 1;
  bool processing = true;
  late RestartableTimer _periodicTimer;

  List<TimeTableEntry?> trainServices = [];

  NetworkModel? _networkModel;

  void initialise(NetworkModel networkModel) {
    _networkModel = networkModel;

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

  /// Refresh local Journey list.
  ///
  void refresh() {
    Arrivals? arrivals = Arrivals(locationName: "----");
    Departures? departures = Departures(locationName: "----");

    trainServices.clear();

    _networkModel!.getArrivals().then((c) {
      arrivals = c;
      if (arrivals != null) {
        TrainService? trainService = arrivals!.trainServices![0];

        trainServices.add(TimeTableEntry(arrivals!.locationName!, trainService!));
        notifyListeners();
      }
    });

    _networkModel!.getDepartures().then((c) {
      departures = c;
      if (departures != null) {
        TrainService? trainService = departures!.trainServices![0];
        trainServices.add(TimeTableEntry(departures!.locationName!, trainService!));
        notifyListeners();
      }
    });

    // Process arrivals and departures for relevant service data

    // For each trainservice in arrivals or departures extract the closest to
    // time now for each possible platform

  }
}