import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure 'flutter_svg' is correctly imported
import 'package:google_fonts/google_fonts.dart';

class salesUserList extends StatefulWidget {
  const salesUserList({super.key});

  @override
  State<salesUserList> createState() => _salesUserListState();
}

class _salesUserListState extends State<salesUserList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height; // Not directly used for ListView height

    // `isCrown` variable is not used to change UI based on its value in the current logic.
    // Keeping it here as per your original code.
    bool isCrown = false;

    return Scaffold(
      backgroundColor: Colors.white, // Consistent white background for the whole screen
      appBar: AppBar(
        // Using standard AppBar for better integration and features
        backgroundColor: Colors.white, // White background for the app bar
        elevation: 0, // No shadow for a cleaner, modern look
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Standard back navigation
          },
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 20, color: Colors.black87), // Slightly softer black for icon
        ),
        title: const Center(
          // Centering the title
          child: Text(
            "Sales Team Users", // More descriptive title
            style: TextStyle(
                fontSize: 18, // Slightly larger font size
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          SizedBox(width: 48), // Placeholder to balance title centering if needed
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Consistent horizontal padding for the list
        child: Column(
          children: [
            SizedBox(height: 10), // Small spacing below app bar
            Expanded( // Use Expanded to allow ListView to take available height
              child: ListView.builder(
                itemCount: 25, // Your original item count
                physics: const BouncingScrollPhysics(), // Softer scroll effect
                itemBuilder: (context, index) {
                  // Simulate some users having the crown (e.g., top 3) for design purposes
                  final bool showCrown = index < 3; // First 3 users get a crown

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // More vertical spacing between list items
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero, // Remove default ListTile padding
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1.5, // Slightly thicker border for avatar
                                    color: Color(0xFFD3E0EA))), // Lighter, subtle border color
                            child: CircleAvatar(
                              radius: 25, // Slightly larger avatar
                              backgroundColor: Color(0xFFE8F4F8), // Very light blue for avatar background
                              child: SvgPicture.asset(
                                "assets/salesGroup.svg", // Using your existing asset
                                height: 28, // Slightly larger SVG icon
                                width: 28,
                                colorFilter: ColorFilter.mode(Color(0xFF164CA1), BlendMode.srcIn), // Apply brand blue color
                              ),
                            ),
                          ),
                          title: Text(
                            "User Name ${index + 1}", // Dynamic user name
                            style: GoogleFonts.poppins(
                                color: Color(0xFF040F20), // Darker text for better contrast
                                fontWeight: FontWeight.w600, // Semi-bold for name
                                fontSize: 16),
                          ),
                          subtitle: Text(
                              "ID: #5436-${index + 1}", // Dynamic ID
                              style: GoogleFonts.poppins( // Use GoogleFonts for subtitle too
                                color: Colors.grey[600], // Softer grey for ID
                                fontSize: 13,
                                fontWeight: FontWeight.normal, // Regular weight for ID
                              )),
                          trailing: showCrown
                              ? SvgPicture.asset(
                            "assets/crown.svg",
                            width: 22, // Slightly larger crown icon
                            height: 22,
                            colorFilter: ColorFilter.mode(Color(0xFFFFD700), BlendMode.srcIn), // Gold color for crown
                          )
                              : null, // Only show crown for specific users
                        ),
                        // Divider only below each item, not last
                        if (index < 24) // Don't show divider after the last item
                          Divider(
                            thickness: 0.8, // Slightly thicker divider
                            color: Colors.grey[300], // Lighter grey for divider
                            endIndent: 0, // No indent at the end
                            indent: 70, // Indent to align with the text content
                          ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}