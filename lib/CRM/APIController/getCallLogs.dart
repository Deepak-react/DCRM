import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // For SocketException

import 'package:demo787/CRM/API/api_const.dart';
import 'package:demo787/CRM/Model/loginModel.dart';
import 'package:demo787/CRM/Services/nativeLogService.dart';
import 'package:demo787/CRM/Services/sharedPreferenceService.dart';
import 'package:demo787/CRM/screens/login/authService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Model/callLogsModel.dart';

class CallLogsController {
  Nativecalllogs nativecalllogs = Nativecalllogs();
  // final String apiUrl = "http://139.59.22.128:3000/api/login";
  final String postCallAPI =
      ApiConstant.api_base_url + ApiConstant.insert_callLogs;

  final String hrms_call_logs_post =
      ApiConstant.hrms_end_points + ApiConstant.call_logs;

  AuthService authService = AuthService();

  Future<List<LogsModel>> getCallLogs() async {
    try {
      // Validate inputs before making API call

      final String? token = await authService.getToken();
      int? user_id = await SharedPrefsHelper.getUserId();
      final String finalUrl =
          "${ApiConstant.api_base_url}${ApiConstant.get_call_logs}/$user_id";

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
        final List<dynamic> jsonData = jsonDecode(response.body);

        //Returns an list of LogsModel Objects
        List<LogsModel> logs =
            jsonData.map((json) => LogsModel.fromJson(json)).toList();


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

  Future<String> postCallLogs(List<Map<String, dynamic>> logsJson) async {
    print("Into the post calls function!!!");
    print("The call logs: $logsJson");

    try {
      // Validate inputs before making API call
      Map<String, dynamic> logJson = logsJson[0];

      if (logsJson.isEmpty) {
        log("call log is empty, something went wrong !!!");
        return "Invalid input";
      }

      print("Into the post calls function2");
      print("the call position at 0th position is : $logJson ");


      // print("The call type is: $callType");

      final String? token = await authService.getToken();
      dynamic callerTypeId = logJson['caller_type_id'];

      dynamic start_time = logJson['call_time'];
      if (callerTypeId == null) {
        print("Caller type ID is null!");
        return "Invalid call type"; // Or handle it appropriately
      }

// Ensure it's an int
      int? parsedCallerTypeId;
      if (callerTypeId is int) {
        parsedCallerTypeId = callerTypeId;
      } else if (callerTypeId is String) {
        parsedCallerTypeId = int.tryParse(callerTypeId);
      }

      if (parsedCallerTypeId == null) {
        print("Caller type ID could not be converted to int!");
        return "Invalid call type";
      }




      String? user_email = await SharedPrefsHelper.getUserEmail();

      String callType = convertTypeId_to_string(parsedCallerTypeId);

      String callStartType = convertToERPNextFormat(start_time);

      print("The call type is: $callType");
      print("The API URL is: $postCallAPI");
      print("The Json value is: ${jsonEncode(logJson)}");


      if (logJson['caller_type_id'] != null) {
        logJson['caller_type_id'] = logJson['caller_type_id'].toString();
      }


      try {
        final response = await http.post(
          Uri.parse(postCallAPI),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(logJson),
        );

        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200) {
          print("Call Logs stored successfully!");
          return "Successful";
        } else if (response.statusCode == 401) {
          print("Unauthorized access - token might be invalid");
          return "Invalid credentials";
        } else if (response.statusCode == 500) {
          print("Server error occurred");
          return "Server error";
        } else {
          print("Unexpected error: ${response.statusCode}");
          return "Failed";
        }
      } on SocketException catch (e) {
        print("No internet connection: $e");
        return "No internet";
      } on FormatException catch (e) {
        print("Bad response format: $e");
        return "Invalid response format";
      } catch (e) {
        print("Unexpected error: $e");
        return "Error";
      }


    } on SocketException {
      log("No internet connection");
      return "No internet";
    } on FormatException {
      log("Invalid JSON response");
      return "Invalid response format";
    } catch (e) {
      log("Unexpected error: $e");
      return "Error";
    }
  }

  String convertTypeId_to_string(int id) {
    print("The convert function !!");
    switch (id) {
      case 1:
        return "Incoming";
      case 2:
        return "Outgoing";
      case 3:
        return "Missed";
      case 4:
        return "Not Attended";
      default:
        return "call not defined";
    }
  }
}

String convertToERPNextFormat(String rawDateTime) {
  DateTime parsedDate = DateTime.parse(rawDateTime);
  String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(parsedDate);
  return formattedDate;
}
