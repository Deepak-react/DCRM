import 'dart:developer';

import 'package:demo787/CRM/screens/Analytics/analytics.dart';
import 'package:demo787/CRM/screens/home/home.dart';
import 'package:demo787/CRM/screens/salesGroup/salesGroupList.dart';
import 'package:demo787/CRM/screens/userSettings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for consistent typography

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

  void tap(int index) { // Changed type to int for clarity
    setState(() {
      _index = index;
    });
  }

  @override
  void initState() {
    _hasPermission();
    // It's generally better to call _init() only after permissions are confirmed
    // or handle its state within _hasPermission's flow.
    // For now, keeping it here as per original, but be aware of its async nature.
    _init();
    super.initState();
  }

  // Helper widget for building individual navigation items
  Widget _buildNavItem(String svgPath, String label, int index) {
    bool isSelected = _index == index;
    return Expanded( // Use Expanded to give each item equal space
      child: Material( // Use Material for tap ripple effect and elevation control
        color: Colors.transparent, // Background controlled by BottomAppBar
        child: InkWell( // For tap effect
          onTap: () => tap(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Vertical padding for tap area
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svgPath,
                    width: 26,
                    height: 26,
                    colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            )
            ,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // screenWidth and screenHeight are not directly used in the final layout
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _selectedIndex[_index],
      extendBody: true, // Allows the body to extend behind the BottomAppBar for better visual effect
      bottomNavigationBar: Container(
        // The outer Container is now just for decorative purposes,
        // if you want a specific rounded background that's separate from BottomAppBar's shape.
        // If not, it can be removed entirely, and BottomAppBar handles all.
        // Let's keep it and adjust its radius to be visually appealing with BottomAppBar.
        decoration: BoxDecoration(
          // Background color for the container if needed to extend below the BottomAppBar's visible part
          color: Colors.transparent, // Or a slightly darker color if extending below
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), // Match BottomAppBar's radius
            topRight: Radius.circular(30), // Match BottomAppBar's radius
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Soft shadow for the entire bar area
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -5), // Shadow above the bar
            ),
          ],
        ),
        child: ClipRRect( // Clip to ensure the Container's radius is respected for the BottomAppBar
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            color: Color(0xFF0D47A1), // Deep navy blue for the bottom bar
            elevation: 0, // Elevation is handled by the parent Container's boxShadow
            shape: AutomaticNotchedShape(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30), // Apply top radius here
                ),
              ),
              // Use null for the StadiumBorder if you don't have a FAB to notch around
              // or keep it if you expect a FAB. Keeping it as it was in original.
              const StadiumBorder(),
            ),
            notchMargin: 8.0, // Increased notch margin for more pronounced curve
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjusted padding
              child: SizedBox( // Give specific height to the content within BottomAppBar
                height: 70, // A fixed height for the content inside the bar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem("assets/bottomHome.svg", "Home", 0),
                    _buildNavItem("assets/bottonAnalytics.svg", "Analytics", 1),
                    SizedBox(width: 40), // Space for potential FAB, or just for visual balance
                    _buildNavItem("assets/bottomSalesGroup.svg", "Sales", 2), // Label for Sales Group
                    _buildNavItem("assets/bottomSettings.svg", "Profile", 3), // Label for Settings
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}