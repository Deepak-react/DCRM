class LogsModel {
  int? userId;
  String? callLogNumber;
  String? callerName;
  String? callTypeId;
  String? callTime;
  int? duration;

  LogsModel(
      {this.userId,
      this.callLogNumber,
      this.callerName,
      this.callTypeId,
      this.callTime,
      this.duration});

  LogsModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    callLogNumber = json['call_log_number'];
    callerName = json['caller_name'];
    callTypeId = json['caller_type_id'];
    callTime = json['call_time'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['call_log_number'] = this.callLogNumber;
    data['caller_name'] = this.callerName;
    data['caller_type_id'] = this.callTypeId;
    data['call_time'] = this.callTime;
    data['duration'] = this.duration;
    return data;
  }
}
