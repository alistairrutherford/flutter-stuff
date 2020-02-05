import 'package:flutter/foundation.dart';
import 'package:provider5/Headlines.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class NewsModel extends ChangeNotifier {
  static const String HEADLINES_DATA = "assets/data/headlines.json";

  Headlines _headlines;

  Headlines get headlines => _headlines;
  set(Headlines headlines) => _headlines = headlines;

  Future updateHeadlines() async {
    _headlines = await loadHeadlines(HEADLINES_DATA);

    notifyListeners();
  }

  Future<Headlines> loadHeadlines(String dataPath) async {
    // Fetch json
    var dataString = await loadAsset(dataPath);

    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    Headlines headlines = Headlines.map(jsonUserData);
    return headlines;
  }

  Future<String> loadAsset(String dataPath) async {
      String data = await rootBundle.loadString(dataPath);
      return data;
  }

}