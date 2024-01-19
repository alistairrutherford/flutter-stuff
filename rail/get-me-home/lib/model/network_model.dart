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
  ApiKeys? _apiKeys;

  /// Chain the initialise.
  void initialise(Function onInit) async {
    this.onInit = onInit;

    // Do await.
    await loadAPIKeys();

    // Call callers onInit().
    onInit();
  }

  /// Fetch Arrivals.
  Future<Arrivals?> getArrivals() async {
    final response = await http.get(Uri.parse(_sharedPreferences.arrivalsURL!),
        headers: {'x-apikey': _apiKeys!.arrivalApiKey});

    var data = jsonDecode(response.body);

    Arrivals? arrivals;

    if (response.statusCode == 200) {
      arrivals = Arrivals.fromJson(data);
    }
    return arrivals;
  }

  /// Fetch Departures.
  Future<Departures?> getDepartures() async {
    final response = await http.get(Uri.parse(_sharedPreferences.departuresURL!),
        headers: {'x-apikey': _apiKeys!.departureApiKey});

    var data = jsonDecode(response.body);

    Departures? departures;

    if (response.statusCode == 200) {
      departures = Departures.fromJson(data);
    }

    return departures;
  }

  /// Load API keys from secret file.
  Future<void> loadAPIKeys() async {
    _apiKeys = await rootBundle
        .loadStructuredData<ApiKeys>('assets/secrets.json', (jsonStr) async {
      final secret = ApiKeys.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}

/// Local API Keys class (loaded from JSON).
class ApiKeys {
  final String departureApiKey;
  final String arrivalApiKey;

  ApiKeys({this.departureApiKey = "", this.arrivalApiKey = ""});

  factory ApiKeys.fromJson(Map<String, dynamic> jsonMap) {
    return ApiKeys(
        departureApiKey: jsonMap["DEPARTURES_KEY"],
        arrivalApiKey: jsonMap["ARRIVALS_KEY"]);
  }
}
