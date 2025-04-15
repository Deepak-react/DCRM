import 'package:demo787/CRM/Services/sharedPreferenceService.dart';

import '../screens/userSettings/settings.dart';

class UserSettingService {
  Future<List<userData>> userTileData() async {
    String? email = await SharedPrefsHelper.getUserEmail();
    String? phone = await SharedPrefsHelper.getUserPhone();
    String? sim_preference = await SharedPrefsHelper.getUserSim();
    // String? role = await SharedPrefsHelper.getUserCompany();
    // String? sales_group = await SharedPrefsHelper.();
    String? company = await SharedPrefsHelper.getUserCompany();

    return [
      userData(label: "Email", value: email!),
      userData(label: "Phone", value: phone!),
      userData(label: "Sim preference", value: sim_preference!),
      userData(label: "Role", value: "Admin"),
      userData(label: "Sales Group", value: "Team CRMx"),
      userData(label: "Company", value: company!)
    ];
  }
}
