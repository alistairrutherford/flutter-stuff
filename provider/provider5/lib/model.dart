import 'package:flutter/foundation.dart';
import 'package:provider5/Headlines.dart';

class NewModel extends ChangeNotifier {
  Headlines _headlines;

  Headlines get headlines => _headlines;
  set(Headlines headlines) => _headlines = headlines;

  updateHeadlines() {
    // TODO Fetch model

    notifyListeners();
  }
}