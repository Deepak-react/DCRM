import 'package:call_log/call_log.dart';
import 'package:demo787/CRM/Services/nativeLogService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../APIController/getCallLogCount.dart';
import '../../Model/callCountModel.dart';
import '../../Model/callLogsModel.dart';

class analytics extends StatefulWidget {
  const analytics({super.key});

  @override
  State<analytics> createState() => _analyticsState();
}

class _analyticsState extends State<analytics> {
  String? selectedToggle = "Summary";
  String? activeCard = "Summary";
  CallCountModel? call_logs_count;

  Nativecalllogs nativecalllogs = Nativecalllogs();

  @override
  void initState() {
    super.initState(); // Always call this first
    fetchCallLogsCount();
  }

  Future<void> fetchCallLogsCount() async {
    List<CallCountModel> logs = await CallCount().getCallLogsCount("week");
    setState(() {
      call_logs_count = logs[0];
    });
  }

  Widget changeCards(String card_name) {
    print("Card name in change card function: $card_name");
    setState(() {
      activeCard = card_name;
      print(
          "Active button value inside the card change functionm: $activeCard");
    });
    print(
        "Active button value outside the set state in change card fn: $activeCard");
    // activeCard == "Summary" ? countCards() : countCards2();
    if (activeCard.toString() == "Summary ") {
      print("True");
      return countCards();
    } else {
      print("False");
      return countCards2();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 100),
                child: Text(
                  "Analytics",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildAnalyticsCard(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 225,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFE9E9E9), // Background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["Summary", "Analytics"].map((label) {
                  return InkWell(
                    onTap: () {
                      print("Label value on tap : $label");
                      setState(() {
                        selectedToggle = label;
                        print(
                            "Selected value after set state : $selectedToggle");
                      });
                      changeCards(selectedToggle!);
                    },
                    child: Container(
                      width: 100, // Adjust button width
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedToggle == label
                            ? Colors.blue // Active button color
                            : Colors.transparent, // Inactive button color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: selectedToggle == label
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(), // Convert map output to list
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: screenHeight * 0.310,
              width: screenWidth,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      activeCard == "Summary" ? countCards() : countCards2(),
                      activeCard == "Summary" ? countCards() : countCards2(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAnalyticsCard() {
    final rodStyleList = [
      // rodStyle(
      //     yAxis: 10,
      //     color: LinearGradient(
      //         colors: [Color(0xFF164CA1), Color(0xFFFFFFFF)],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter),
      //     width: 8,
      //     radius: BorderRadius.circular(2)),
      rodStyle(
          yAxis: (call_logs_count?.rejectedCalls ?? 0).toDouble(),
          color: LinearGradient(
              colors: [Color(0xFFFFD502), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: 8,
          radius: BorderRadius.circular(2)),
      rodStyle(
          yAxis: (call_logs_count?.incomingCalls ?? 0).toDouble(),
          color: LinearGradient(
              colors: [Color(0xFF40FF00), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: 8,
          radius: BorderRadius.circular(2)),
      // rodStyle(
      //     yAxis: 25,
      //     color: LinearGradient(
      //         colors: [Color(0xFFFF0000), Color(0xFFFFFFFF)],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter),
      //     width: 8,
      //     radius: BorderRadius.circular(2)),
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(13),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Color(0xFF3F6CB3),
            ),
            height: screenHeight * 0.375,
            width: screenWidth * 0.9,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Statics",
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 15),
                  ),
                  subtitle: Text(
                    "Sales stats",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  trailing: SizedBox(
                    height: 35,
                    width: 110,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: Color(0xFFF8F8FF)),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Week"),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        )),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 30, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    height: screenHeight * 0.265,
                    width: screenWidth * 0.8,
                    child: AspectRatio(
                      aspectRatio: 5,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.start,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFE5E5EF),
                                  width: 1), // Visible bottom border
                              left: BorderSide.none, // Hide left border
                              right: BorderSide.none, // Hide right border
                              top: BorderSide.none, // Hide top border
                            ),
                          ),
                          maxY: 60,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                interval: 30,
                                showTitles: true, // Show Y-axis labels
                                reservedSize: 40,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    reservedSize:
                                        40, // Increase size for visibility
                                    showTitles: true,
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
                                      Map<int, String> weekMap = {
                                        1: 'M',
                                        2: 'T',
                                        3: 'W',
                                        4: 'Th',
                                        5: 'F',
                                        6: 'Sa'
                                      };
                                      return Text(weekMap[value.toInt()] ?? '',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold));
                                    }
                                    // getTitlesWidget: (value, meta) {
                                    //   const style = TextStyle(
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 14,
                                    //   );
                                    //
                                    //   final Map<int, String> weekDays = {
                                    //     0: 'Mo',
                                    //     1: 'Tu',
                                    //     2: 'We',
                                    //     3: 'Th',
                                    //     4: 'Fr',
                                    //     5: 'Sa',
                                    //     6: 'Su',
                                    //   };
                                    //
                                    //   return
                                    //     fitInside: meta
                                    //         .axisSide, // Fix: Provide required argument
                                    //     child: Text(weekDays[value.toInt()] ?? '',
                                    //         style: style),
                                    //   );
                                    // },
                                    )),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Hide top labels
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  reservedSize: 0,
                                  showTitles: false), // Hide right labels
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          barGroups: List.generate(
                              6,
                              (index) => BarChartGroupData(
                                  x: index + 1,
                                  barsSpace: 8,
                                  barRods: rodStyleList
                                      .asMap()
                                      .entries
                                      .map((mapEntry) {
                                    final index = mapEntry.key;
                                    final data = mapEntry.value;
                                    return BarChartRodData(
                                      gradient: data.color,
                                      borderRadius: data.radius,
                                      toY: data.yAxis,
                                      width: data.width,
                                    );
                                  }).toList()
                                  // For group incoming, outgoing and then missed calls
                                  )),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget countCards() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 120,
            width: screenWidth * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/missedCall.svg",
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Total calls",
                        style: TextStyle(
                            color: Color(0xFF164CA1),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.black,
                        size: 21,
                      ),
                      Text(
                        "18",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/callTime.svg",
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "26m 0s",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget countCards2() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 120,
            width: 163,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/meeting.svg",
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Total calls",
                        style: TextStyle(
                            color: Color(0xFF164CA1),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.black,
                        size: 21,
                      ),
                      Text(
                        "18",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/meeting.svg",
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "26m 0s",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final Map<int, String> weekDays = {
      0: 'Mo',
      1: 'Tu',
      2: 'We',
      3: 'Th',
      4: 'Fr',
      5: 'Sa',
      6: 'Su',
    };

    return SideTitleWidget(
      meta: meta,
      child: Text(weekDays[value.toInt()] ?? '', style: style),
    );
  }
}

class rodStyle {
  final double yAxis;
  final double width;
  final LinearGradient color;
  final BorderRadius radius;

  rodStyle(
      {required this.yAxis,
      required this.color,
      required this.width,
      required this.radius});
}
