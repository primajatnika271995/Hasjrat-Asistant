import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper _instance;
  static SharedPreferences _sharedPreferences;

  static const String kAccessToken = "accessToken";
  static const String kSalesName = "salesName";
  static const String kSalesNIK = "salesNIK";
  static const String kSalesBirthday = "salesBirthday";
  static const String kSalesGender = "salesGender";
  static const String kSalesBranch = "salesBranch";
  static const String kSalesOutlet = "salesOutlet";
  static const String kSalesJob = "salesJob";

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

    return prefs.getString(kSalesName) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the sales name
  /// ----------------------------------------------------------
  static Future<bool> setSalesName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesName, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales NIK, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesNIK() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kSalesNIK) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the sales NIK
  /// ----------------------------------------------------------
  static Future<bool> setSalesNIK(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesNIK, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales gender, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kSalesGender) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the gender
  /// ----------------------------------------------------------
  static Future<bool> setSalesGender(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesGender, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales tanggal lahir, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesBirthday() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kSalesBirthday) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the tanggal lahir
  /// ----------------------------------------------------------
  static Future<bool> setSalesBirthday(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesBirthday, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales brach, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesBrach() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kSalesBranch) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the salse branch
  /// ----------------------------------------------------------
  static Future<bool> setSalesBrach(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesBranch, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales outlet, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesOutlet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kSalesOutlet) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the sales outlet
  /// ----------------------------------------------------------
  static Future<bool> setSalesOutlet(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesOutlet, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the sales job, 'null' if not set
  /// ------------------------------------------------------------
  static Future<String> getSalesJob() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kSalesJob) ?? null;
  }

  /// ----------------------------------------------------------
  /// Method that saves the sales job
  /// ----------------------------------------------------------
  static Future<bool> setSalesJob(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kSalesJob, value);
  }


}