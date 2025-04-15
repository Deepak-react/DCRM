import 'dart:developer';

import 'package:demo787/CRM/APIController/getCallLogs.dart';
import 'package:demo787/CRM/Services/nativeLogService.dart';
import 'package:demo787/CRM/screens/Salesgrouplist/salesUserGroup.dart';
import 'package:demo787/CRM/screens/home/bottomNavigation.dart';
import 'package:demo787/CRM/screens/home/home.dart';
import 'package:demo787/hrmam.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:demo787/pg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CRM/screens/Analytics/analytics.dart';
import 'CRM/screens/login/login.dart';
import 'CRM/screens/salesGroup/salesGroupList.dart';
import 'bottom.dart';
import 'cheakbox.dart';
import 'in.dart';
import 'in2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Failed to load .env: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _message = "";
  // String _callState = "Idle"; // Store call state
  // final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();

    PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);

    // requestDefaultDialer();
    // startListeningForCalls();
  }

  // .

  // void requestDefaultDialer() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? isDialerSet = prefs.getBool('isDialerSet');
  //
  //   if (isDialerSet == null || !isDialerSet) {
  //     var intent = AndroidIntent(
  //       action: 'android.telecom.action.CHANGE_DEFAULT_DIALER',
  //       package: 'com.example.demo787', // Replace with actual package name
  //     );
  //     await intent.launch();
  //
  //     // Save that permission was requested
  //     await prefs.setBool('isDialerSet', true);
  //   }
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF7F5FF)),
          // textTheme: TextTheme(
          //     bodyMedium: GoogleFonts.montserrat(color: Colors.white)),
          useMaterial3: true,
        ),
        home:
            // salesUserList());
            // custom_bottom());
            // salesGroup());
            login());
    // Home());
    // analytics());
    // ImagePickerScreen());
    // hrmam());

    // StatusScreen());
  }
}
