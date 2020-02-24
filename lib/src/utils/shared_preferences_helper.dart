import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper _instance;
  static SharedPreferences _sharedPreferences;

  static const String kAccessToken = "accessToken";
  static const String kSalesName = "accessToken";

  static Future<SharedPreferencesHelper> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesHelper();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  /// ------------------------------------------------------------
  /// Method that returns the access token, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kAccessToken) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the access token
  /// ----------------------------------------------------------
  static Future<bool> setAccessToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kAccessToken, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales name, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kAccessToken) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the sales name
  /// ----------------------------------------------------------
  static Future<bool> setSalesName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kAccessToken, value);
  }


}