import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

class TimerModel extends ChangeNotifier {
  late RestartableTimer _periodicTimer;
  int seconds = 0;
  bool dirty = false;
  bool running = false;

  TimerModel() {
    // One-shot restartable timer.
    _periodicTimer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        seconds++;
        if (running) {
          _periodicTimer.reset();
        }
        notifyListeners();
      },
    );
    _periodicTimer.cancel();
    seconds = 0;
  }

  void start() {
    running = true;
    dirty = true;
    _periodicTimer.reset();
    notifyListeners();
  }

  void pause() {
    _periodicTimer.cancel();
    running = false;
    notifyListeners();
  }

  void resume() {
    running = true;
    _periodicTimer.reset();
    notifyListeners();
  }
  void finish() {
    _periodicTimer.cancel();
    running = false;
    dirty = false;
    seconds = 0;
    notifyListeners();
  }
}
