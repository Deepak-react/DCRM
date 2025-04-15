import 'package:call_log/call_log.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Model/callTypeModel.dart';

class callType {
  final String baseUrl = "http://139.59.22.128";

  Future<List<CallTypeModel>> fetchAndSaveCallTypes() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/getCallTypes"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CallTypeModel> callTypes =
            data.map((e) => CallTypeModel.fromJson(e)).toList();

        // Save to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("callTypes", CallTypeModel.toJsonList(callTypes));

        return callTypes;
      } else {
        throw Exception("Failed to fetch call types");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }

  Future<List<CallTypeModel>> getStoredCallTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? callTypesJson = prefs.getString("callTypes");

    if (callTypesJson != null) {
      return CallTypeModel.fromJsonList(callTypesJson);
    } else {
      return [];
    }
  }

  Future<void> sendCallTypeId(int callTypeId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/updateCallState"),
        body: json.encode({"callTypeId": callTypeId}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Call type updated successfully!");
      } else {
        print("Failed to update call type");
      }
    } catch (e) {
      print("Error updating call type: $e");
    }
  }
}
