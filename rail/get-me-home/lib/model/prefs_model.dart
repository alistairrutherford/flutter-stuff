import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Stores local shared pref. Since some other service may rely on these values we have
/// onInit call-back.
class SharedPreferencesModel extends ChangeNotifier {
  static const String prefArrivalsURL = "ARRIVALS_URL";
  static const String defaultArrivalsURL = "https://api1.raildata.org.uk/1010-live-arrival-board-arr/LDBWS/api/20220120/GetArrBoardWithDetails/MLN";

  static const String prefDeparturesURL = "DEPARTURES_URL";
  static const String defaultDeparturesURL = "https://api1.raildata.org.uk/1010-live-departure-board-dep/LDBWS/api/20220120/GetDepBoardWithDetails/MLN";

  static const String prefApiKey = "API_KEY";

  String? arrivalsURL;
  String? departuresURL;
  String? apiKey;

  SharedPreferencesModel() {
    initialise();
  }

  void initialise() async {
    // load secrets
    loadAsset();

    apiKey = await loadAsset();

    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    // Setup Prefs

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
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/secrets.txt');
  }
}
