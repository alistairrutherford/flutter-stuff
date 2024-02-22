class ParserHelper {

  static String? parseIntString(Map<String, dynamic> json, String key) {
    String? value = null;

    try {
      // Straight
      value = json[key].toString();
    }
    catch (e) {
      try {
        value = json[key];
      }
      catch (e) {
       print(e);
      }
    }

    return value;
  }

}