import 'dart:convert';

class CallTypeModel {
  final int id;
  final String name;

  CallTypeModel({required this.id, required this.name});

  factory CallTypeModel.fromJson(Map<String, dynamic> json) {
    return CallTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }

  static List<CallTypeModel> fromJsonList(String jsonString) {
    List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => CallTypeModel.fromJson(item)).toList();
  }

  static String toJsonList(List<CallTypeModel> callTypes) {
    return json.encode(callTypes.map((e) => e.toJson()).toList());
  }
}
