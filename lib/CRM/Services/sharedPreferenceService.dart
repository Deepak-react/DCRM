import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String emailKey = "email";
  static const String phoneKey = "phone";
  static const String companyKey = "company";
  static const String nameKey = "name";
  static const String userIdKey = "user_id";
  static const String simKey = "sim_slot";

  // Save user data
  static Future<void> saveUserData({
    required String? email,
    required String? company,
    required int? user_id,
    required String? sim_slot,
    required String? phone_number,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email!);
    await prefs.setString(companyKey, company!);
    await prefs.setInt(userIdKey, user_id!);
    await prefs.setString(phoneKey, phone_number!);
    await prefs.setString(simKey, sim_slot!);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey);
  }

  static Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }

  static Future<String?> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phoneKey);
  }

  static Future<String?> getUserSim() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(simKey);
  }

  static Future<String?> getUserCompany() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(companyKey);
  }

  // Remove user data (For logout)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(emailKey);
    await prefs.remove(phoneKey);
    await prefs.remove(companyKey);
    await prefs.remove(nameKey);
    await prefs.remove(userIdKey);
  }
}
