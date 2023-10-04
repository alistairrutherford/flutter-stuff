import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

class TimerModel extends ChangeNotifier {
  RestartableTimer? _periodicTimer;
  int seconds = 0;

  TimerModel() {
    _periodicTimer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        seconds++;
        notifyListeners();
      },
    );
    _periodicTimer!.cancel();
    seconds = 0;
  }

  void start() {
    _periodicTimer!.reset();
  }

  void stop() {
    _periodicTimer!.cancel();
  }
}
