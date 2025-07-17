import 'package:demo787/CRM/Services/settingService.dart';
import 'package:demo787/CRM/Services/sharedPreferenceService.dart';
import 'package:demo787/CRM/screens/home/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Exclude_contacts/contactsList.dart';

class userSettings extends StatefulWidget {
  const userSettings({super.key});

  @override
  State<userSettings> createState() => _userSettingsState();
}

class _userSettingsState extends State<userSettings> {
  // `_isExpanded` is for the commented-out expandable section, kept as original.
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width; // Not directly used in the final design
    // double screenHeight = MediaQuery.of(context).size.height; // Not directly used in the final design

    return Scaffold(
      backgroundColor: Colors.white, // Consistent white background
      appBar: AppBar(
        // Using standard AppBar for better integration
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a cleaner look
        leading: IconButton(
          onPressed: () {
            // Navigate back to the bottom navigation, not necessarily 'custom_bottom()' directly
            Navigator.pop(context);
            // Example if you specifically want to go to a particular tab in bottom navigation
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => custom_bottom(initialIndex: 0)), // Go to home tab
            //       (Route<dynamic> route) => false,
            // );
          },
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 20, color: Colors.black87), // Soft black icon
        ),
        title: const Center(
          // Center the title
          child: Text(
            "Profile",
            style: TextStyle(
                fontSize: 18, // Slightly larger font
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          SizedBox(width: 48), // To balance the centered title
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Consistent padding
              child: ListTile(
                contentPadding: EdgeInsets.zero, // Remove default padding
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Circular shape for the border
                    border: Border.all(
                      width: 2, // Thicker border for profile picture
                      color: Color(0xFF9BC9FF).withOpacity(0.5), // Softer, semi-transparent blue border
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30, // Larger avatar for profile
                    backgroundColor: Color(0xFFD6F2FB), // Light blue background
                    child: SvgPicture.asset(
                      "assets/user1.svg", // Using user1.svg as a placeholder for profile pic
                      width: 40, // Larger SVG for profile pic
                      height: 40,
                      colorFilter: ColorFilter.mode(Color(0xFF164CA1), BlendMode.srcIn), // Brand blue color
                    ),
                  ),
                ),
                title: Text(
                  "Deepak_Yeager", // Display name prominently
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Larger font for name
                      color: Color(0xFF040F20)), // Darker text for readability
                ),
                subtitle: Text(
                  "Sal#01554", // Display ID below the name
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, // Regular weight for ID
                      fontSize: 14,
                      color: Colors.grey[700]), // Softer grey for ID
                ),
              ),
            ),
            SizedBox(height: 25), // Increased spacing

            // Account Section
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 10.0), // Consistent left padding
              child: Text(
                "Account",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040F20)), // Darker text for heading
              ),
            ),
            FutureBuilder<List<userData>>(
              future: UserSettingService().userTileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF164CA1))); // Styled loading indicator
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Error: ${snapshot.error}", style: GoogleFonts.poppins(color: Colors.red)),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("No Account Data Available", style: GoogleFonts.poppins(color: Colors.grey[700])),
                  );
                }

                return Column(
                  children: snapshot.data!.map((data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), // Consistent padding
                      child: Material(
                        elevation: 4, // Softer shadow
                        borderRadius: BorderRadius.circular(15), // More rounded corners
                        shadowColor: Colors.grey.withOpacity(0.15), // Lighter, diffused shadow
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 0.8, color: Color(0xFFE5E5E5)), // Subtle light grey border
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding inside ListTile
                            title: Text(data.label,
                                style: GoogleFonts.poppins(
                                    fontSize: 13, // Slightly larger font for label
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700])), // Softer grey for label
                            subtitle: Text(data.value,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, // Larger font for value
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF040F20))), // Darker text for value
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            SizedBox(height: 30), // Increased spacing

            // General Section
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 10.0), // Consistent left padding
              child: Text(
                "General",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040F20)), // Darker text for heading
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), // Consistent padding
              child: Material(
                elevation: 4, // Softer shadow
                borderRadius: BorderRadius.circular(15), // More rounded corners
                shadowColor: Colors.grey.withOpacity(0.15), // Lighter, diffused shadow
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.8, color: Color(0xFFE5E5E5)), // Subtle light grey border
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding inside ListTile
                    title: Text(
                      "Exclude Contacts", // Corrected label
                      style: GoogleFonts.poppins(
                          fontSize: 15, // Adjusted font size
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF040F20)), // Darker text for title
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Exclude_contact_list()));
                        },
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18)), // Modern forward icon, softer color
                  ),
                ),
              ),
            ),

            // Placeholder for the commented-out expandable section.
            // If you decide to re-implement it, ensure its design aligns with the new aesthetic.
            // Example of how it might look, still commented out:
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            //   child: Material(
            //     elevation: 4,
            //     borderRadius: BorderRadius.circular(15),
            //     shadowColor: Colors.grey.withOpacity(0.15),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(15),
            //         border: Border.all(width: 0.8, color: Color(0xFFE5E5E5)),
            //       ),
            //       child: Column(
            //         children: [
            //           ListTile(
            //             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //             title: Text(
            //               "Advanced Settings",
            //               style: GoogleFonts.poppins(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w500,
            //                   color: Color(0xFF040F20)),
            //             ),
            //             trailing: IconButton(
            //               onPressed: () {
            //                 setState(() {
            //                   _isExpanded = !_isExpanded;
            //                 });
            //               },
            //               icon: Icon(
            //                 _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            //                 color: Colors.grey, size: 20,
            //               ),
            //             ),
            //           ),
            //           if (_isExpanded)
            //             Padding(
            //               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text("Notification Preferences", style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
            //                   SizedBox(height: 5),
            //                   Text("Data Usage", style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
            //                 ],
            //               ),
            //             ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(height: 40), // Increased bottom spacing
          ],
        ),
      ),
    );
  }

  // The `userDataTile` widget is not used in the enhanced code as the FutureBuilder directly maps
  // to the desired ListTile design. Keeping it for reference if you plan to use it elsewhere.
  Widget userDataTile(label, value) {
    return Column(
      children: [
        ListTile(
          title: Text(label),
          subtitle: Text(value),
        )
      ],
    );
  }
}

// Assuming userData and other services/models are defined correctly elsewhere
class userData {
  final String label;
  final String value;
  userData({required this.label, required this.value});
}