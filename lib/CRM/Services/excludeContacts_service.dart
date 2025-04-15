import 'dart:convert';
import 'dart:developer';

import 'package:demo787/CRM/API/api_const.dart';
import 'package:demo787/CRM/Model/contactsModel.dart';
import 'package:demo787/CRM/Services/sharedPreferenceService.dart';
import 'package:demo787/CRM/screens/login/authService.dart';
import 'package:http/http.dart' as http;

class Exclude_contacts_service {
  String getContactsURL =
      ApiConstant.api_base_url + ApiConstant.get_excluded_numbers;

  String postContactURL =
      ApiConstant.api_base_url + ApiConstant.create_excludedContacts;

  AuthService authService = AuthService();

  Future<List<ContactsModel>> get_contacts_list() async {
    final String? token = await authService.getToken();
    int? user_id = await SharedPrefsHelper.getUserId();

    print(user_id);

    try {
      final response = await http.get(Uri.parse("$getContactsURL/$user_id"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ContactsModel> contacts =
            data.map((e) => ContactsModel.fromJson(e)).toList();

        return contacts;
      } else {
        throw Exception("Failed to fetch call types");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }

  Future<Map<String, dynamic>> postExcludeContacts(
      exclude_name, exclude_number, reason) async {
    int? user_id = await SharedPrefsHelper.getUserId();
    final String? token = await authService.getToken();
    Map<String, dynamic> data = {
      "user_id": user_id,
      "e_name": exclude_name,
      "e_number": exclude_number,
      "reason": reason
    };
    try {
      final response = await http.post(Uri.parse(postContactURL),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        log("This is response data: $data");

        return data;
      } else {
        throw Exception("Failed to fetch call types");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
