import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores local shared pref. Note on startup we generate a unique device id
/// which will be used when posting journeys to uniquely identify source
/// of data.
class SharedPrefsModel extends ChangeNotifier {
  static const String deviceID = "http://10.0.2.2:8080/journeyrec/journey";

  SharedPrefsModel() {
    initialise();
  }

  void initialise() async {
    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    String? deviceId = prefs.getString(deviceID);

    if (deviceId == null) {
      // Generate
      var uuid = const Uuid();
      String id = uuid.v4();
      await prefs.setString(deviceID, id);
    }
  }
}
