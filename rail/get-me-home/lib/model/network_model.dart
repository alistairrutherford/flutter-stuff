import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_me_home/dao/arrivals.dart';
import 'package:get_me_home/dao/departures.dart';
import 'package:get_me_home/model/prefs_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

/// This provider model handle sending journey data to server.
class NetworkModel extends ChangeNotifier {
  final _sharedPreferences = SharedPreferencesModel();

  Function? onInit;
  String? _apiKey;

  /// Chain the initialise.
  void initialise(Function onInit) async {
    this.onInit = onInit;

    // Do await.
    loadAPIKey();

    // Call callers onInit().
    onInit();
  }

  /// Fetch Arrivals.
  Future<List<Arrivals>> getArrivals() async {
    final response = await http.get(
        Uri.parse(_sharedPreferences.arrivalsURL!),
        headers: {'x-apikey': _apiKey!}
    );

    var data = jsonDecode(response.body.toString());

    List<Arrivals> arrivals = List.empty(growable: true);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        arrivals.add(Arrivals.fromJson(index));
      }
      return arrivals;
    }
    return arrivals; //empty list
  }

  /// Fetch Departures.
  Future<List<Departures>> getDepartures() async {
    final response = await http.get(
        Uri.parse(_sharedPreferences.departuresURL!),
        headers: {'x-apikey': _apiKey!}
    );

    var data = jsonDecode(response.body.toString());

    List<Departures> departures = List.empty(growable: true);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        departures.add(Departures.fromJson(index));
      }
      return departures;
    }
    return departures; //empty list
  }

  Future<void> loadAPIKey() async {
    String secret = await rootBundle.loadString('assets/secrets.txt');
    _apiKey = secret.split("=").last;
  }
}
