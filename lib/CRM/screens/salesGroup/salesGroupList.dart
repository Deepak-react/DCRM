import 'package:demo787/colors.dart'; // Assuming this defines your color palette
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Salesgrouplist/salesUserGroup.dart';

class salesGroup extends StatefulWidget {
  const salesGroup({super.key});

  @override
  State<salesGroup> createState() => _salesGroupState();
}

class _salesGroupState extends State<salesGroup> {
  // `isBlob` state variable is not used in the final design for visual changes,
  // but kept as per your original code.
  bool isBlob = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final salesRank = [
      salesRankData(
          values: 3, height: screenHeight * 0.12, image: "assets/user3.svg"), // Adjusted height and order for visual hierarchy
      salesRankData(
          values: 1, height: screenHeight * 0.18, image: "assets/user1.svg"), // Tallest for 1st place
      salesRankData(
          values: 2, height: screenHeight * 0.15, image: "assets/user2.svg"), // Mid-height for 2nd place
    ];

    // Sort by height for correct display order if not manually ordered above
    // salesRank.sort((a, b) => a.values.compareTo(b.values)); // Sort by rank number

    return Scaffold(
      backgroundColor: Colors.white, // Ensure consistent white background
      appBar: AppBar(
        // Using standard AppBar instead of PreferredSize for better integration
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a cleaner, modern look
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new, // More common back icon
            color: Colors.black87, // Slightly softer black
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context); // Example back navigation
          },
        ),
        title: Center(
          // Center the title
          child: Text(
            "Sales Group",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        actions: [
          SizedBox(width: 48), // To balance the centered title if needed
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Sales Rank Section
            Material(
              elevation: 8, // Softer, more pronounced shadow
              borderRadius: BorderRadius.circular(20), // More rounded corners
              shadowColor: Colors.grey.withOpacity(0.3), // Lighter, diffused shadow
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20), // Increased vertical padding
                height: screenHeight * 0.35, // Adjusted height to accommodate changes
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient( // Added subtle gradient for depth
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE0F2F7), // Light blue-grey start
                      Color(0xFFD6EEF5), // Slightly darker end
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Top Performers",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF164CA1), // Brand blue for title
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView( // Makes content scrollable to prevent overflow
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: salesRank.map((rank) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min, // Prevents taking full vertical space
                              children: [
                                SvgPicture.asset(
                                  rank.image,
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.05,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  rank.values == 1
                                      ? "Alice"
                                      : (rank.values == 2 ? "Bob" : "Charlie"),
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                    color: rank.values == 1
                                        ? Color(0xFFFFD700)
                                        : (rank.values == 2
                                        ? Color(0xFFC0C0C0)
                                        : Color(0xFFCD7F32)),
                                  ),
                                  width: screenWidth * 0.18,
                                  height: rank.height,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${rank.values}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30, // Increased spacing
            ),
            // Sales Group List Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added horizontal padding
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sales Teams", // Clearer section title
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040F20), // Dark text for heading
                  ),
                ),
              ),
            ),
            SizedBox(height: 15), // Spacing below title
            Container(
              height: screenHeight * 0.465, // Keep original height
              width: screenWidth * 0.9,
              child: ScrollConfiguration(
                behavior: ScrollBehavior()
                    .copyWith(overscroll: false, scrollbars: false),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              isBlob = !isBlob; // Still triggers a state change, but no visual effect based on isBlob
                            });
                            // You can add Navigator.push here if tap on card should go to salesUserList
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => salesUserList()));
                          },
                          child: salesGroupList());
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget salesGroupList() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Material(
          elevation: 6, // Softer shadow
          borderRadius: BorderRadius.circular(15), // More rounded corners
          shadowColor: Colors.grey.withOpacity(0.2), // Lighter, diffused shadow
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => salesUserList()));
            },
            borderRadius: BorderRadius.circular(15), // Match Material's border radius for tap effect
            child: Container(
              // height: screenHeight * 0.2, // Let content dictate height
              width: screenWidth * 0.9, // Slightly wider to match main card width
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xFFF0F0F0), width: 1)), // Subtle light grey border
              child: Column(
                children: [
                  Material(
                    color: Color(0xFF194283), // Darker blue for the header
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), // Match container's radius
                        topRight: Radius.circular(15)),
                    elevation: 0, // No elevation needed here, main Material handles it
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Added padding
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 1.5, color: Color(0xFF9BC9FF))), // Slightly thicker border for avatar
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFD6F2FB), // Lighter blue for avatar background
                            child: SvgPicture.asset(
                              "assets/salesGroup.svg",
                              height: 30,
                              width: 30,
                              colorFilter: ColorFilter.mode(Color(0xFF164CA1), BlendMode.srcIn), // Apply brand color to SVG
                            ),
                          ),
                        ),
                        title: Text(
                          "Team CRMx",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600, // Semi-bold
                              fontSize: 17),
                        ),
                        subtitle: Text(
                          "Sales Group ID: 12345", // More descriptive subtitle
                          style: GoogleFonts.poppins(
                            color: Colors.white70, // Softer white for subtitle
                            fontSize: 13,
                            fontWeight: FontWeight.normal, // Regular weight
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 15, // Increased spacing
                  ),
                  listCardDetails("Group Leader", "Rishi"),
                  listCardDetails("Best Performance", "Vignesh"),
                  listCardDetails("Total Calls", "250"),
                  SizedBox(height: 15), // Padding at the bottom
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20, // Spacing between cards in the list
        )
      ],
    );
  }

  Widget listCardDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Consistent padding
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween for aligned text
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, // Regular weight
                  color: Colors.grey[700], // Softer grey
                  fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft, // Align value to left
              child: Text(
                value,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040F20), // Darker text for values
                    fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class salesRankData {
  final int values;
  final double height;
  final String image;

  salesRankData({
    required this.values,
    required this.height,
    required this.image,
  });
}