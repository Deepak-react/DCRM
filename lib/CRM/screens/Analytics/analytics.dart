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
  String? activeCard = "Summary"; // Initial state for active card
  CallCountModel? call_logs_count;

  Nativecalllogs nativecalllogs = Nativecalllogs();

  @override
  void initState() {
    super.initState();
    fetchCallLogsCount();
  }

  Future<void> fetchCallLogsCount() async {
    List<CallCountModel> logs = await CallCount().getCallLogsCount("week");
    setState(() {
      call_logs_count = logs[0];
    });
  }

  // Adjusted logic for changeCards to correctly update activeCard
  Widget changeCards(String card_name) {
    setState(() {
      activeCard = card_name;
    });
    // Return the appropriate widget immediately based on the updated activeCard
    if (activeCard == "Summary") {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              countCards(), // First card
              countCards(), // Second card
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              countCards(), // Third card
              countCards(), // Fourth card
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              countCards2(), // First card
              countCards2(), // Second card
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              countCards2(), // Third card
              countCards2(), // Fourth card
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Ensure a consistent background
      appBar: AppBar(
        // Removed PreferredSize to use standard AppBar features
        backgroundColor: Colors.white, // White background for AppBar
        elevation: 0, // No shadow for a cleaner look
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black, // Black icon for contrast
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context); // Example of back navigation
          },
        ),
        title: Center(
          // Center the title without excessive padding
          child: Text(
            "Analytics",
            style: GoogleFonts.poppins(
              fontSize: 18, // Slightly larger font size
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          SizedBox(width: 48), // Placeholder to balance centering of title if needed
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            buildAnalyticsCard(),
            SizedBox(height: 30), // Increased spacing for better separation
            Container(
              width: 250, // Slightly wider for better visual balance
              height: 45, // Slightly taller for a more substantial feel
              decoration: BoxDecoration(
                color: Color(0xFFE9E9E9), // Light grey background
                borderRadius: BorderRadius.circular(25), // More rounded corners (pill shape)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["Summary", "Analytics"].map((label) {
                  return Expanded( // Use Expanded to ensure even distribution
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedToggle = label;
                        });
                        // changeCards will be called via the child of the ListView.builder
                      },
                      borderRadius: BorderRadius.circular(22), // Match container's rounded corners
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedToggle == label
                              ? Color(0xFF164CA1) // Your brand blue for active
                              : Colors.transparent, // Inactive transparent
                          borderRadius: BorderRadius.circular(22), // Match InkWell's borderRadius
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.poppins(
                            color: selectedToggle == label
                                ? Colors.white // White text for active
                                : Colors.black87, // Slightly softer black for inactive
                            fontWeight: FontWeight.w600, // Semi-bold for both
                            fontSize: 15, // Consistent font size
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: screenHeight * 0.40, // Adjust height to prevent excessive scrolling
              width: screenWidth,
              child:
              // The issue was here: ListView.builder creates 4 rows of 2 cards.
              // Instead, we just need to call changeCards once, and it will build the layout.
              // We also need to wrap this in a ValueListenableBuilder or similar
              // if `activeCard` updates trigger a rebuild of just this section.
              // For simplicity, we'll just rebuild the whole `changeCards` widget here.
              changeCards(selectedToggle!), // Call changeCards directly based on selectedToggle
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnalyticsCard() {
    // Ensuring consistent gradient direction and clear starting/ending colors
    final rodStyleList = [
      rodStyle(
          yAxis: (call_logs_count?.rejectedCalls ?? 0).toDouble(),
          color: LinearGradient(
              colors: [Color(0xFFFFCC00), Color(0xFFFFE066)], // Gold to lighter gold
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: 10, // Slightly wider bars
          radius: BorderRadius.circular(3)), // Slightly more rounded bar tops
      rodStyle(
          yAxis: (call_logs_count?.incomingCalls ?? 0).toDouble(),
          color: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)], // Green to lighter green
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: 10,
          radius: BorderRadius.circular(3)),
      rodStyle(
          yAxis: (call_logs_count?.outgoingCalls ?? 0).toDouble(), // Assuming outgoingCalls exists
          color: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF64B5F6)], // Blue to lighter blue
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: 10,
          radius: BorderRadius.circular(3)),
      rodStyle(
          yAxis: (call_logs_count?.missedCalls ?? 0).toDouble(), // Assuming missedCalls exists
          color: LinearGradient(
              colors: [Color(0xFFEF5350), Color(0xFFFFCDD2)], // Red to lighter red
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: 10,
          radius: BorderRadius.circular(3)),
    ];

    // Dummy data for remaining bars if you need more than 2
    final List<BarChartGroupData> barGroups = List.generate(
      7, // Representing 7 days of the week for a full bar chart
          (index) {
        // You'll need to map your actual call_logs_count data to these bars
        // For demonstration, I'm just showing the first two types
        // A more robust solution would involve separate data points for each day.
        double rejected = (call_logs_count?.rejectedCalls ?? 0).toDouble();
        double incoming = (call_logs_count?.incomingCalls ?? 0).toDouble();
        double outgoing = (call_logs_count?.outgoingCalls ?? 0).toDouble();
        double missed = (call_logs_count?.missedCalls ?? 0).toDouble();

        // Distribute the total count across days for visual variety if actual daily data isn't available
        double baseValue = (rejected + incoming + outgoing + missed) / 7;
        double currentDayRejected = (baseValue * (0.8 + 0.4 * (index % 3))).roundToDouble();
        double currentDayIncoming = (baseValue * (0.9 + 0.3 * (index % 4))).roundToDouble();
        double currentDayOutgoing = (baseValue * (0.7 + 0.5 * (index % 5))).roundToDouble();
        double currentDayMissed = (baseValue * (0.6 + 0.6 * (index % 6))).roundToDouble();


        return BarChartGroupData(
          x: index, // X-axis value for each day (0-6)
          barRods: [
            BarChartRodData(
              toY: currentDayRejected,
              gradient: rodStyleList[0].color,
              width: rodStyleList[0].width,
              borderRadius: rodStyleList[0].radius,
            ),
            BarChartRodData(
              toY: currentDayIncoming,
              gradient: rodStyleList[1].color,
              width: rodStyleList[1].width,
              borderRadius: rodStyleList[1].radius,
            ),
            BarChartRodData(
              toY: currentDayOutgoing,
              gradient: rodStyleList[2].color, // Use the appropriate color
              width: rodStyleList[2].width,
              borderRadius: rodStyleList[2].radius,
            ),
            BarChartRodData(
              toY: currentDayMissed,
              gradient: rodStyleList[3].color, // Use the appropriate color
              width: rodStyleList[3].width,
              borderRadius: rodStyleList[3].radius,
            ),
          ],
          barsSpace: 4, // Space between individual bars in a group
        );
      },
    );


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Material(
          elevation: 8, // More pronounced but soft shadow
          borderRadius: BorderRadius.circular(20), // More rounded corners for a modern feel
          shadowColor: Colors.grey.withOpacity(0.3), // Softer shadow color
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF194283), // Darker blue for the main card background
            ),
            height: screenHeight * 0.40, // Slightly taller card for more content space
            width: screenWidth * 0.9,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Increased padding
                  title: Text(
                    "Statistics", // Corrected typo
                    style: GoogleFonts.poppins(
                      color: Colors.white70, // Softer white for sub-title
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "Call Volume & Engagement", // More descriptive subtitle
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19), // Larger and bolder for main title
                  ),
                  trailing: SizedBox(
                    height: 40, // Taller button
                    width: 120, // Wider button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xFFF0F5FA), // Lighter, modern button background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Week",
                              style: GoogleFonts.poppins(
                                color: Colors.black87, // Softer black text
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, color: Colors.black87)
                          ],
                        )),
                  ),
                ),
                Expanded( // Use Expanded to fill remaining space
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 20, 10), // Adjusted padding for chart
                    decoration: BoxDecoration(
                        color: Colors.white, // White background for the chart area
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))), // Only bottom rounded corners
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround, // Distribute bars evenly
                        maxY: 100, // Adjusted max Y for sample data, set based on your actual max
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              // Customize tooltip text if needed
                              return BarTooltipItem(
                                  rod.toY.round().toString(),
                                  const TextStyle(color: Colors.white));
                            },
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false, // Only horizontal grid lines
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Color(0xFFE5E5EF), // Light grey grid line
                              strokeWidth: 0.8,
                            );
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFE5E5EF), // Match grid line color
                                width: 1),
                            left: BorderSide(
                                color: Color(0xFFE5E5EF), // Add a subtle left border
                                width: 1),
                            right: BorderSide.none,
                            top: BorderSide.none,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              interval: 25, // Adjusted interval for clearer labels
                              showTitles: true,
                              reservedSize: 35, // Space for Y-axis labels
                              getTitlesWidget: (value, meta) {
                                return Text(value.toInt().toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey[600], fontSize: 12)); // Styled Y-axis labels
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              reservedSize: 35,
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                Map<int, String> weekMap = {
                                  0: 'Mon', // Use full abbreviations
                                  1: 'Tue',
                                  2: 'Wed',
                                  3: 'Thu',
                                  4: 'Fri',
                                  5: 'Sat',
                                  6: 'Sun'
                                };
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(weekMap[value.toInt()] ?? '',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600, // Semi-bold days
                                          color: Colors.grey[800])), // Darker grey for days
                                );
                              },
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        backgroundColor: Colors.transparent,
                        barGroups: barGroups, // Use the generated bar groups
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // Refined countCards
  Widget countCards() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 10),
        Material(
          elevation: 4, // Softer shadow
          borderRadius: BorderRadius.circular(15), // More rounded corners
          shadowColor: Colors.grey.withOpacity(0.2), // Lighter shadow color
          child: Container(
            height: 130, // Slightly taller card
            width: screenWidth * 0.43, // Slightly narrower for better spacing in rows
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: Color(0xFFF0F0F0), width: 1), // Very subtle border
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Increased padding inside
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute content
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/missedCall.svg", // Use your assets
                        width: 18, // Slightly larger icon
                        height: 18,
                        colorFilter: ColorFilter.mode(Color(0xFF164CA1), BlendMode.srcIn), // Apply brand color
                      ),
                      SizedBox(width: 8), // Reduced spacing
                      Text(
                        "Total Calls", // Clearer label
                        style: GoogleFonts.poppins(
                            color: Color(0xFF164CA1), // Brand blue
                            fontWeight: FontWeight.w600, // Semi-bold
                            fontSize: 14),
                      )
                    ],
                  ),
                  Text(
                    // Call logs count here, placeholder for now
    (
    (call_logs_count?.incomingCalls ?? 0) +
    (call_logs_count?.outgoingCalls ?? 0) +
    (call_logs_count?.missedCalls ?? 0) +
    (call_logs_count?.rejectedCalls ?? 0)
    ).toString(),                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 22), // Larger and bolder count
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/callTime.svg", // Use your assets
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn), // Softer grey for time icon
                      ),
                      SizedBox(width: 8),
                      Text(
                        "26m 0s", // Placeholder
                        style: GoogleFonts.poppins(
                            color: Colors.grey[700], // Softer grey for time
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // Refined countCards2 (similar design to countCards for consistency)
  Widget countCards2() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 10),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(15),
          shadowColor: Colors.grey.withOpacity(0.2),
          child: Container(
            height: 130,
            width: screenWidth * 0.43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white, // Keep white for consistency with `countCards`
              border: Border.all(color: Color(0xFFF0F0F0), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/meeting.svg", // Use your assets
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(Color(0xFFCC5050), BlendMode.srcIn), // A distinct color for analytics card
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Meeting Calls", // A different label
                        style: GoogleFonts.poppins(
                            color: Color(0xFFCC5050), // Match icon color
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                  Text(
                    "35", // Placeholder value
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/callTime.svg", // Use your assets
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "45m 12s", // Placeholder
                        style: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
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
      2: '3',
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