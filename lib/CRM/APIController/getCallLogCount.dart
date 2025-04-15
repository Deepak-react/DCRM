import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo787/CRM/API/api_const.dart';
import 'package:demo787/CRM/Model/callCountModel.dart';
import 'package:demo787/CRM/screens/login/authService.dart';
import 'package:http/http.dart' as http;

import '../Services/sharedPreferenceService.dart';

class CallCount {
  Future<List<CallCountModel>> getCallLogsCount(String duration) async {
    AuthService authService = AuthService();
    try {
      // Validate inputs before making API call

      final String? token = await authService.getToken();
      int? user_id = await SharedPrefsHelper.getUserId();

      final String finalUrl =
          "${ApiConstant.api_base_url}${ApiConstant.today_call_count}/$user_id/$duration";

      print("The access token is: $token");

      final response = await http.get(
        Uri.parse(finalUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      print('The response is : $response');
      print(response.body);

      // Check the HTTP response code
      if (response.statusCode == 200) {
        print("Get call Logs service");
        final List<dynamic> jsonData = jsonDecode(response.body);

        print("The json call logs are: $jsonData");

        //Returns an list of LogsModel Objects
        List<CallCountModel> logs =
            jsonData.map((json) => CallCountModel.fromJson(json)).toList();

        print("The list of call logs length are: ${logs.length}");

        return logs;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid token");
      } else if (response.statusCode == 500) {
        throw Exception("Server error. Please try again later.");
      } else {
        log("Unexpected response: ${response.body}");
        throw Exception("Failed to fetch call logs");
      }
    } on SocketException {
      log("No internet connection");
      throw Exception("No internet connection");
    } on FormatException {
      log("Invalid JSON response");
      throw Exception("Invalid response format");
    } catch (e) {
      log("Unexpected error: $e");
      throw Exception("Something went wrong");
    }
  }
}
