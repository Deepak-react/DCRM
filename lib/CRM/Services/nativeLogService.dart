import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:demo787/CRM/Model/callLogsModel.dart';
import 'package:demo787/CRM/Services/sharedPreferenceService.dart';
import 'package:phone_state_background/src/phone_state_background_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Nativecalllogs {
  Future<List<Map<String, dynamic>>> fetchRecentCallLogs(
      String? detectedNumber, PhoneStateBackgroundEvent event) async {
    int? user_id = await SharedPrefsHelper.getUserId();

    String? sim_slot = await SharedPrefsHelper.getUserSim();
    if (detectedNumber == null) return [];

    String detectedEvent = event.name;

    Iterable<CallLogEntry> entries = await getCallLogs();

    List<LogsModel> matchingLogs = [];

    String callType = "";
    for (var entry in entries) {
      String logNumber = entry.number ?? "Unknown";
      DateTime logTime =
          DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);

      if (entry.callType == CallType.outgoing && entry.duration == 0) {
        print("Call not attended !!!");
        callType = "Not attended";
        print(entry.simDisplayName);

        print(detectedEvent);
        print(entry.callType);
        print(entry.timestamp);
        print(entry.formattedNumber);
        print(logNumber);
        print(entry.phoneAccountId);
        print(sim_slot);

        // && entry.phoneAccountId == 1

        if (logNumber == detectedNumber) {
          print("Demo2");
          print("Matched Call Log: Number: $logNumber, Time: $logTime");
          int callTypeId = getCallTypeId(callType);
          matchingLogs.add(LogsModel(
              callTypeId: callTypeId.toString(),
              callLogNumber: entry.number,
              callerName: entry.name,
              callTime: logTime.toString(),
              duration: entry.duration,
              userId: user_id));
        }
      } else {
        print(entry.simDisplayName);

        print(detectedEvent);
        print(entry.callType);
        print(entry.timestamp);
        print(entry.formattedNumber);
        print(logNumber);
        print(entry.phoneAccountId);
        print(sim_slot);
        callType = normalizeCallType(entry.callType.toString());

        print("This is an incoming call fn");

        // entry.phoneAccountId == sim_slot &&

        // Match detected number with call log
        if (logNumber == detectedNumber && callType == detectedEvent) {
          print("Demo");
          print(
              "Matched Call Log: Number: $logNumber, Time: $logTime, Type: $callType");
          int callTypeId = getCallTypeId(callType);

          matchingLogs.add(LogsModel(
              callTypeId: callTypeId.toString(),
              callLogNumber: entry.number,
              callerName: entry.name,
              callTime: logTime.toString(),
              duration: entry.duration,
              userId: user_id));
        }
      }
    }

    return matchingLogs.map((log) => log.toJson()).toList();
  }

  // Convert the callTypes into callTypeId
  int getCallTypeId(String callType) {
    switch (callType) {
      case "incomingend":
        return 1;
      case "outgoingend":
        return 2;
      case "incomingmissed":
        return 3;
      case "Not attended":
        return 4;
      default:
        return -1; // Default if callType is not found
    }
  }

  // Convert CallType class into an string
  String normalizeCallType(String callType) {
    switch (callType.toLowerCase()) {
      case "calltype.missed":
        return "incomingmissed"; // Matches detectedEvent value
      case "calltype.incoming":
        return "incomingend";
      case "calltype.outgoing":
        return "outgoingend";
      case "calltype.rejected":
        return "rejected";
      default:
        return "unknown"; // Handles unexpected values
    }
  }

  // Function to call logs from the phone
  Future<List<CallLogEntry>> getCallLogs() async {
    print("Waiting for 3 seconds before fetching call logs...");

    await Future.delayed(Duration(seconds: 5)); // Introduce a delay

    Iterable<CallLogEntry> entries = await CallLog.get();
    List<CallLogEntry> last10Entries = entries.take(10).toList();

    return last10Entries;
  }
}
