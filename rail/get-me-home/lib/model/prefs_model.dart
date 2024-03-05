import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores local shared pref. Since some other service may rely on these values we have
/// onInit call-back.
class SharedPreferencesModel extends ChangeNotifier {
  static const String prefArrivalsURL = "ARRIVALS_URL";
  static const String defaultArrivalsURL = "https://api1.raildata.org.uk/1010-live-arrival-board-arr/LDBWS/api/20220120/GetArrBoardWithDetails/";

  static const String prefDeparturesURL = "DEPARTURES_URL";
  static const String defaultDeparturesURL = "https://api1.raildata.org.uk/1010-live-departure-board-dep/LDBWS/api/20220120/GetDepBoardWithDetails/";

  static const String prefStation = "STATION";
  static const String defaultStation = "BRN";

  String? arrivalsURL;
  String? departuresURL;
  String? station;

  Future<void> initialise() async {
    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    // ---------- Setup Prefs ----------

    // Arrivals
    arrivalsURL = prefs.getString(prefArrivalsURL);
    if (arrivalsURL == null) {
      // Generate default.
      arrivalsURL = defaultArrivalsURL;
      await prefs.setString(prefArrivalsURL, arrivalsURL!);
    }

    // Departures
    departuresURL = prefs.getString(prefDeparturesURL);
    if (departuresURL == null) {
      // Generate default.
      departuresURL = defaultDeparturesURL;
      await prefs.setString(prefDeparturesURL, departuresURL!);
    }

    // Chosen station
    station = prefs.getString(prefStation);
    if (station == null) {
      // Generate default.
      station = defaultStation;
      await prefs.setString(prefStation, station!);
    }
  }
}
