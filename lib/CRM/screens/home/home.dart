import 'package:animate_do/animate_do.dart';
import 'package:call_log/call_log.dart';
import 'package:demo787/CRM/APIController/getCallLogCount.dart';
import 'package:demo787/CRM/APIController/getCallLogs.dart';
import 'package:demo787/CRM/Model/callLogsModel.dart';
import 'package:demo787/CRM/Services/nativeLogService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../Model/callCountModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CallCountModel? call_logs_count;

  @override
  void initState() {
    super.initState(); // Fetch logs before building the widget
    fetchCallLogsCount();
  }

  Future<void> fetchCallLogsCount() async {
    List<CallCountModel> logs = await CallCount().getCallLogsCount("today");
    setState(() {
      call_logs_count = logs[0];
    });
  }

  CallLogsController callLogsController = CallLogsController();
  int chartTouchIndex = -1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const textStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13);
    final pieChartData = [
      MyData(value: 10, color: Color(0xFF3F6CB3)),
      MyData(value: 30, color: Color(0xFF164CA1)),
      // MyData(value: 40, color: Colors.white),
      // MyData(value: 20, color: Colors.white),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Blue Top Container
                  Container(
                      height: screenHeight * 0.275,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft, // Start from bottom left
                          end: Alignment.topRight, // End at top right
                          colors: [
                            Color(0xFF040F20), // Left bottom color
                            Color(0xFF194283), // Right top color
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          BounceInRight(
                            child: SizedBox(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.065,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "search",
                                  hintStyle: TextStyle(),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      "assets/search_2.svg",
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ),
                        ],
                      )),

                  // Black Bottom Container (Half Outside)
                  Positioned(
                      top: screenHeight * 0.175 -
                          (screenHeight * 0.05) / 2, // Half out
                      left: (screenWidth - (screenWidth * 0.8)) / 2, // Centered
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: screenHeight * 0.23,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.3), // Shadow color with opacity
                              blurRadius: 10, // Soften the shadow
                              spreadRadius: 2, // Spread of the shadow
                              offset: Offset(4, 4), // Position of shadow (X, Y)
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.001,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  containerCard(
                                      "Incoming",
                                      call_logs_count?.incomingCalls
                                              ?.toString() ??
                                          'Loading...'),
                                  containerCard(
                                      "Outgoing",
                                      call_logs_count?.outgoingCalls
                                              ?.toString() ??
                                          'Loading...')
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  containerCard(
                                      "Missed",
                                      call_logs_count?.missedCalls
                                              ?.toString() ??
                                          'Loading...'),
                                  containerCard(
                                      "Rejected",
                                      call_logs_count?.rejectedCalls
                                              ?.toString() ??
                                          'Loading...')
                                ],
                              ),

                              // Text(
                              //   "Total Calls",
                              //   style: GoogleFonts.poppins(
                              //       fontWeight: FontWeight.bold, fontSize: 15),
                              // ),
                              // Text(
                              //   call_logs_count.length.toString(),
                              //   style: GoogleFonts.poppins(
                              //       fontWeight: FontWeight.w300, fontSize: 15),
                              // ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: screenHeight * 0.480,
              width: screenWidth,

              child: FutureBuilder(
                  future: callLogsController.getCallLogs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: customLoading()); // Show loading
                    } else if (snapshot.hasError) {
                      return Center(
                          child:
                              Text("Error: ${snapshot.error}")); // Show error
                    } else if (snapshot.data == null ||
                        (snapshot.data as List).isEmpty) {
                      return Center(child: Text("No call logs available"));
                    } else {
                      List<LogsModel> logs = snapshot.data!;

                      return ListView.builder(
                        itemCount: logs.length ?? 0, // Default to 0 if null
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              callLogsCard(logs[index]),
                            ],
                          );
                        },
                      );
                    }
                  }),
              // child: ListView.builder(
              //   itemCount: 5, // Number of items
              //   itemBuilder: (context, index) {
              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         callLogsCard(),
              //       ],
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget callLogsCard(LogsModel logs) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: screenHeight * 0.17,
          width: screenWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF164CA1), // Border color
              width: 2, // Border width
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF164CA1), // Shadow same as border
                offset: Offset(2, 2), // Moves the shadow (X, Y)
                blurRadius: 0, // No blur, just offset
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  "assets/letter-d.svg",
                  width: 30,
                  height: 30,
                ),
                title: Text(
                  logs.callerName.toString(),
                ),
                subtitle: Text(
                  logs.callLogNumber.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(logs.duration.toString()),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset: Offset(3, 3), // Shadow offset (X, Y)
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFFF4F5FB),
                        child: SvgPicture.asset("assets/reminder.svg")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset: Offset(3, 3), // Shadow offset (X, Y)
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFFF4F5FB),
                        child: SvgPicture.asset("assets/meeting.svg")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset: Offset(3, 3), // Shadow offset (X, Y)
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFFF4F5FB),
                        child: SvgPicture.asset("assets/notes.svg")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset: Offset(3, 3), // Shadow offset (X, Y)
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                        backgroundColor: Color(0xFFF4F5FB),
                        child: SvgPicture.asset("assets/call.svg")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customLoading() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        height: screenHeight * 0.09,
        width: screenWidth * 0.2,
        child: LoadingIndicator(indicatorType: Indicator.pacman, colors: [
          Color(0xFF164CA1),
          Color(0xFFDBE4F2),
        ]),
      ),
    );
  }

  Widget containerCard(String label, String count) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.080,
      width: screenWidth * 0.33,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFF164CA1).withOpacity(0.2),
      ),
      child: Column(
        // children: [Text("data"), Text("data")],

        children: [
          Row(children: [
            Icon(
              Icons.call,
              color: Colors.green,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 15),
            )
          ]),
          Text(count,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class MyData {
  final double value;
  final Color color;

  MyData({required this.value, required this.color});
}
