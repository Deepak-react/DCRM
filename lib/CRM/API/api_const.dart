class ApiConstant {
  // static const String host = "143.110.178.254:3005/";
  static const String host = "192.168.1.75:3005/";
  static const String host0 = "192.168.0.124:3005/";

  static const String hrms_call_logs = "hrms.xcodefix.in/";
  static const String securedSchema = "https://";
  // static const String port = ":3005/";
  static const String schema = "http://";
  static const String api_base = "api";
  static const String api_hrms_base = "api/resource";
  static const String auth_base = "auth";

  static const String hrms_end_points =
      "$securedSchema$hrms_call_logs$api_hrms_base";

// final URL
  static const String api_base_url = "$schema$host$api_base";
  static const String auth_base_url = "$schema$host$auth_base";


  static const String add_user = "/add-user";
  static const String create_sales_group = "/create-sales-group";
  static const String assign_sales_group_user = "/create-sales-group-user";
  static const String create_excludedContacts = "/create-excludedContacts";
  static const String login = "/login";
  static const String insert_callLogs = "/create-callLogs";
  static const String get_excluded_numbers = "/getExcludedNumbers";
  static const String exclude_numbers = "/excludedNumbers";
  static const String today_call_count = "/getCallCount";
  static const String get_call_logs = "/getCallLogs";
  static const String edit_user = "/user";
  static const String call_logs = "/CRM Call Log";
  static const String edit_sales_user = "/sales-group-user";
  static const String edit_exclude_contacts = "/excluded-contacts";
}
