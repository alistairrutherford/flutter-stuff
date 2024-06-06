import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores local shared pref. Note on startup we generate a unique device id
/// which will be used when posting journeys to uniquely identify source
/// of data.
class SharedPreferencesModel extends ChangeNotifier {
  static const String prefDeviceID = "DEVICE_ID";

  String? deviceId;

  SharedPreferencesModel() {
    initialise();
  }

  void initialise() async {
    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    deviceId = prefs.getString(prefDeviceID);

    if (deviceId == null) {
      // Generate
      var uuid = const Uuid();
      String id = uuid.v4();
      await prefs.setString(prefDeviceID, id);
      deviceId = id;
    }
  }
}
