import 'dart:developer';

import 'package:demo787/CRM/screens/Analytics/analytics.dart';
import 'package:demo787/CRM/screens/home/home.dart';
import 'package:demo787/CRM/screens/salesGroup/salesGroupList.dart';
import 'package:demo787/CRM/screens/userSettings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_background/phone_state_background.dart';

import '../../../main.dart';
import '../../APIController/getCallLogs.dart';
import '../../Services/nativeLogService.dart';

@pragma('vm:entry-point')
Future<void> phoneStateBackgroundCallbackHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,
) async {
  //Find away to declare the Class in any other place
  Nativecalllogs nativecalllogs = Nativecalllogs();
  CallLogsController callLogsController = CallLogsController();
  //Only consider the Incoming end, Incoming missed and the Outgoing end (duration 0s for outgoing not attended & duration Xs for outgoing made )
  switch (event) {
    case PhoneStateBackgroundEvent.incomingstart:
      log('Incoming call start, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.incomingmissed:
      List<Map<String, dynamic>> logsJson =
          await nativecalllogs.fetchRecentCallLogs(
              number, PhoneStateBackgroundEvent.incomingmissed);
      callLogsController.postCallLogs(logsJson);

      print('Incoming call missed, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.incomingreceived:
      log('Incoming call received, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.incomingend:
      List<Map<String, dynamic>> logsJson = await nativecalllogs
          .fetchRecentCallLogs(number, PhoneStateBackgroundEvent.incomingend);
      callLogsController.postCallLogs(logsJson);
      log('Incoming call ended, number: $number, duration $duration s');
      break;
    case PhoneStateBackgroundEvent.outgoingstart:
      log('Ougoing call start, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.outgoingend:
      List<Map<String, dynamic>> logsJson = await nativecalllogs
          .fetchRecentCallLogs(number, PhoneStateBackgroundEvent.outgoingend);
      callLogsController.postCallLogs(logsJson);
      log('Ougoing call ended, number: $number, duration: $duration s');
      break;
  }
}

class custom_bottom extends StatefulWidget {
  const custom_bottom({super.key});

  @override
  State<custom_bottom> createState() => _custom_bottomState();
}

class _custom_bottomState extends State<custom_bottom> {
  bool hasPermission = false;

  Future<void> _hasPermission() async {
    final permission = await PhoneStateBackground.checkPermission();
    log("Permission status: $permission");

    if (!permission) {
      await _requestPermission();
    }
    if (mounted) {
      setState(() => hasPermission = permission);
    }
    await _init();
  }

  Future<void> _requestPermission() async {
    await PhoneStateBackground.requestPermissions();

    await [
      Permission.phone,
      Permission.contacts,
    ].request();
  }

  Future<void> _init() async {
    if (hasPermission != true) return;
    log("Initializing PhoneStateBackground...");
    await PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);
  }

  final List<Widget> _selectedIndex = [
    Home(),
    analytics(),
    salesGroup(),
    userSettings()
  ];

  int _index = 0;

  void tap(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  void initState() {
    _hasPermission();
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _selectedIndex[_index],
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80), topRight: Radius.circular(80))),
          height: screenHeight * 0.08,
          width: screenWidth,
          child: BottomAppBar(
            color: Colors.black,
            shape: AutomaticNotchedShape(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30), // Set top radius
                ),
              ),
              StadiumBorder(), // Ensures FloatingActionButton notch appears correctly
            ),

            notchMargin: 6.0, // Adds curved effect
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent),
                    onPressed: () => tap(0),
                    child: SvgPicture.asset(
                      "assets/bottomHome.svg",
                      width: 30,
                      height: 30,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent),
                    onPressed: () => tap(1),
                    child: SvgPicture.asset(
                      "assets/bottonAnalytics.svg",
                      width: 30,
                      height: 30,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent),
                    onPressed: () => tap(2),
                    child: SvgPicture.asset(
                      "assets/bottomSalesGroup.svg",
                      width: 30,
                      height: 30,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent),
                    onPressed: () => tap(3),
                    child: SvgPicture.asset(
                      "assets/bottomSettings.svg",
                      width: 30,
                      height: 30,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
