import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

class TimerModel extends ChangeNotifier {
  RestartableTimer? _periodicTimer;
  int seconds = 0;
  bool dirty = false;
  bool running = false;

  TimerModel() {
    _periodicTimer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        seconds++;
        if (running) {
          _periodicTimer!.reset();
        }
        notifyListeners();
      },
    );
    _periodicTimer!.cancel();
    seconds = 0;
  }

  void start() {
    running = true;
    dirty = true;
    _periodicTimer!.reset();
  }

  void stop() {
    running = false;
    _periodicTimer!.cancel();
    seconds = 0;
  }
}
