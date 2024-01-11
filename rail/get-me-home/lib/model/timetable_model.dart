import 'package:flutter/material.dart';

import '../dao/arrivals.dart';
import '../dao/departures.dart';
import 'network_model.dart';

class TimeTableModel extends ChangeNotifier {


  List<Arrivals> _arrivals = [];
  List<Departures> _departusers = [];

  /// Refresh local Journey list.
  ///
  void refresh(NetworkModel networkModel) {
    networkModel.getArrivals().then((c) {
      _arrivals = c;
      notifyListeners();
    });
    networkModel.getArrivals().then((c) {
      _arrivals = c;
      notifyListeners();
    });
  }
}