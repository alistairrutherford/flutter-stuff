import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider5/news.dart';

class NewsModel extends ChangeNotifier {
  static const String HEADLINES_DATA = "assets/data/headlines.json";

  News _news;

  News  get headlines => _news;
  set(News news) => _news = news;

  Future updateHeadlines() async {
    // Fetch json
    var dataString = await loadAsset(HEADLINES_DATA);

    _news = loadNews(dataString);

    notifyListeners();
  }

  News loadNews(String dataString) {
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    News headlines = News.fromMap(jsonUserData);
    return headlines;
  }

  Future<String> loadAsset(String dataPath) async {
      String data = await rootBundle.loadString(dataPath);
      return data;
  }

}