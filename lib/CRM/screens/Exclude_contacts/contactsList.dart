import 'package:demo787/CRM/Model/contactsModel.dart';
import 'package:demo787/CRM/Services/sharedPreferenceService.dart';
import 'package:demo787/CRM/screens/Exclude_contacts/create_exclude_contacts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG assets

import '../../Services/excludeContacts_service.dart';

class Exclude_contact_list extends StatefulWidget {
  const Exclude_contact_list({super.key});

  @override
  State<Exclude_contact_list> createState() => _Exclude_contact_listState();
}

class _Exclude_contact_listState extends State<Exclude_contact_list> {
  // Instance of the service to fetch data
  Exclude_contacts_service excludeService = Exclude_contacts_service();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Consistent white background
      appBar: AppBar(
        // Using standard AppBar for consistency
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a cleaner look
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87, size: 20), // Soft black icon
        ),
        title: const Center(
          // Center the title
          child: Text(
            "Excluded Contacts", // More concise and professional title
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
      body: Column( // Changed to Column as SingleChildScrollView will wrap the whole body
        children: [
          // Top Summary and Action Buttons Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Consistent padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space evenly
              children: [
                // "E-Contacts count" Card
                Material(
                  elevation: 8, // Softer, more pronounced shadow
                  borderRadius: BorderRadius.circular(20), // More rounded corners
                  shadowColor: Colors.grey.withOpacity(0.3), // Lighter, diffused shadow
                  child: Container(
                    height: screenHeight * 0.2, // Fixed height for consistent look
                    width: screenWidth * 0.45,
                    padding: const EdgeInsets.all(16), // Increased padding
                    decoration: BoxDecoration(
                      gradient: LinearGradient( // Subtle gradient for depth
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF67B7DC), // Softer blue start
                          Color(0xFF4C9ED9), // Slightly darker blue end
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                      children: [
                        Text(
                          "Excluded Contacts", // Clearer label
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600), // Semi-bold for label
                        ),
                        SizedBox(height: 8), // Spacing between label and count
                        Text(
                          "20", // Placeholder count, replace with actual data
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 60, // Larger font for the count
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                // Action Buttons Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                  children: [
                    _buildActionButton(
                      context,
                      label: "Exclude New", // Clearer label for adding
                      color: Color(0xFF164CA1), // Brand blue
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Create_exclude_contacts()));
                      },
                      iconPath: "assets/add_contact.svg", // Example SVG asset if you have one
                    ),
                    SizedBox(height: 15), // Spacing between buttons
                    _buildActionButton(
                      context,
                      label: "Edit List", // Clearer label for editing
                      color: Color(0xFF4CAF50), // Green for edit action
                      onTap: () {
                        // Implement edit functionality
                        print("Edit button tapped");
                      },
                      iconPath: "assets/edit_icon.svg", // Example SVG asset
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20), // Spacing before the list

          // Excluded Contacts List Section
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 10.0), // Consistent left padding
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "List of Excluded Contacts",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040F20)), // Dark text for heading
              ),
            ),
          ),
          Expanded( // Expanded to make the ListView take available space
            child: FutureBuilder<List<ContactsModel>>(
                future: excludeService.get_contacts_list(), // Use the service instance
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF164CA1))); // Styled loading indicator
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Error loading contacts: ${snapshot.error}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(color: Colors.red)),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("No excluded contacts found.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(color: Colors.grey[700])),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding for the list items
                    physics: const BouncingScrollPhysics(), // Softer scroll
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero, // Remove default ListTile padding
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.5,
                                    color: Color(0xFFD3E0EA)), // Subtle border
                              ),
                              child: CircleAvatar(
                                radius: 24, // Slightly smaller than profile pic, but good for list
                                backgroundColor: Color(0xFFE8F4F8), // Light blue background
                                child: Icon(Icons.person, color: Color(0xFF164CA1), size: 28), // Generic person icon for list
                                // Or use an SVG if you have one specifically for contact list items
                                // SvgPicture.asset(
                                //   "assets/contact_icon.svg",
                                //   height: 28,
                                //   width: 28,
                                //   colorFilter: ColorFilter.mode(Color(0xFF164CA1), BlendMode.srcIn),
                                // ),
                              ),
                            ),
                            title: Text(
                              data.excludedContactName ?? 'Unknown Name', // Handle null safely
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF040F20),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.excludedContactNumber ?? 'No Number', // Handle null safely
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                if (data.reason != null && data.reason!.isNotEmpty)
                                  Text(
                                    'Reason: ${data.reason}', // Display reason if available
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                            trailing: IconButton( // Add an action icon for each list item
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                              onPressed: () {
                                // Implement logic to un-exclude contact
                                print("Remove ${data.excludedContactName} tapped");
                              },
                            ),
                            onTap: () {
                              // Optional: navigate to contact details or show more info
                              print("Tapped on: ${data.excludedContactName}");
                            },
                          ),
                          if (index < snapshot.data!.length - 1) // Don't show divider after the last item
                            Divider(
                              thickness: 0.8,
                              color: Colors.grey[300],
                              indent: 70, // Indent to align with text
                              endIndent: 0,
                            ),
                        ],
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  // Helper widget for the action buttons
  Widget _buildActionButton(
      BuildContext context, {
        required String label,
        required Color color,
        required VoidCallback onTap,
        required String iconPath, // New parameter for SVG icon
      }) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: color, // Use the provided color
      borderRadius: BorderRadius.circular(15), // Consistent rounded corners
      elevation: 5, // A bit of elevation
      shadowColor: color.withOpacity(0.4), // Shadow matching button color
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 60, // Fixed height for a uniform look
          width: screenWidth * 0.4, // Adjusted width
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center content in row
            children: [
              SvgPicture.asset(
                iconPath, // Use the provided SVG path
                height: 24, // Icon size
                width: 24,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn), // White icon
              ),
              SizedBox(width: 8), // Spacing between icon and text
              Text(
                label,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16, // Larger font for button text
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Assuming ContactsModel and Exclude_contacts_service are defined elsewhere.
// contactsModel example (adjust as per your actual model)
// class ContactsModel {
//   final String? excludedContactName;
//   final String? excludedContactNumber;
//   final String? reason; // Added reason to model
//
//   ContactsModel({this.excludedContactName, this.excludedContactNumber, this.reason});
//
//   factory ContactsModel.fromJson(Map<String, dynamic> json) {
//     return ContactsModel(
//       excludedContactName: json['excludedContactName'],
//       excludedContactNumber: json['excludedContactNumber'],
//       reason: json['reason'],
//     );
//   }
// }