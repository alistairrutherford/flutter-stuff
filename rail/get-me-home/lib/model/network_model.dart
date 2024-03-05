import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_me_home/dao/arrivals.dart';
import 'package:get_me_home/dao/departures.dart';
import 'package:get_me_home/model/prefs_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

/// Implement fetching data.
/// TODO make the URL more efficient by concatenating this inside the prefs.
class NetworkModel extends ChangeNotifier {
  late SharedPreferencesModel _sharedPreferences;

  Function? onInit;
  ApiKeys? _apiKeys;

  /// Chain the initialise.
  Future<void> initialise(SharedPreferencesModel sharedPreferencesModel, [Function? onInit]) async {
    this._sharedPreferences = sharedPreferencesModel;

    this.onInit = onInit;

    // Do await.
    await loadAPIKeys();

    // Call callers onInit().
    if (onInit != null) onInit();
  }

  /// Fetch Arrivals.
  Future<Arrivals?> getArrivals() async {
    String station = _sharedPreferences.station!;
    String url = _sharedPreferences.arrivalsURL! + station;
    final response = await http.get(Uri.parse(url),
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
    String station = _sharedPreferences.station!;
    String url = _sharedPreferences.departuresURL! + station;
    final response = await http.get(Uri.parse(url),
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
