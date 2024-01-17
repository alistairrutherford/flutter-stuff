import 'package:flutter/material.dart';

import '../dao/arrivals.dart';
import '../dao/callingpoint.dart';
import '../dao/departures.dart';
import 'network_model.dart';

class TimeTableModel extends ChangeNotifier {

  List<TrainService?> arrivals = [];
  List<TrainService?> departures = [];
  NetworkModel? _networkModel;

  void initialise(NetworkModel networkModel) {
    _networkModel = networkModel;
    networkModel.initialise(onInit);
  }

  void onInit() {
    refresh();
  }

  /// Refresh local Journey list.
  ///
  void refresh() {
    _networkModel!.getArrivals().then((c) {
      arrivals = c;
      notifyListeners();
    });
    _networkModel!.getDepartures().then((c) {
      departures = c;
      notifyListeners();
    });
  }
}