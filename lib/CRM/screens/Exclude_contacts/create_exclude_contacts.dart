import 'package:animate_do/animate_do.dart';
import 'package:demo787/CRM/Services/excludeContacts_service.dart';
import 'package:demo787/CRM/screens/userSettings/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming fonst.dart and contactsModel.dart are correctly defined
// import '../../../fonst.dart'; // This import seems unused in the provided snippet
import '../../Model/contactsModel.dart';

class Create_exclude_contacts extends StatefulWidget {
  const Create_exclude_contacts({super.key});

  @override
  State<Create_exclude_contacts> createState() =>
      _Create_exclude_contactsState();
}

class _Create_exclude_contactsState extends State<Create_exclude_contacts> {
  final _formKey = GlobalKey<FormState>();
  // `isSelected` is not used in the provided logic, keeping it as original.
  bool isSelected = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Exclude_contacts_service exclude_contacts_service =
  Exclude_contacts_service();

  final FocusNode _focusNode0 = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void dispose() {
    _focusNode0.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    nameController.dispose(); // Dispose controllers
    numberController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width; // Not directly used for dimensions
    // double screenHeight = MediaQuery.of(context).size.height; // Not directly used for dimensions

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
            "Exclude Contact Form", // More descriptive and professional title
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
        padding: const EdgeInsets.all(20.0), // Overall padding for the form
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
            children: [
              SizedBox(height: 25),

              // Name Input Field
              BounceInRight(
                child: TextFormField(
                  controller: nameController,
                  focusNode: _focusNode0,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Contact Name", // Use labelText for better UX
                    labelStyle: GoogleFonts.poppins(color: Colors.grey[700]), // Style for label
                    hintText: "Enter contact name", // Clearer hint
                    hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Color(0xFFF0F5FA), // Lighter, subtle background color
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), // More rounded corners
                      borderSide: BorderSide(color: Color(0xFFE0E5EB), width: 1), // Subtle border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF164CA1), width: 2), // Brand blue border on focus
                    ),
                    errorBorder: OutlineInputBorder( // Style for error state
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder( // Style for focused error state
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Increased padding
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the contact name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(height: 20),

              // Phone Number Input Field
              BounceInLeft(
                child: TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone, // Use phone keyboard type
                  focusNode: _focusNode1,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                    hintText: "Enter 10-digit phone number",
                    hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Color(0xFFF0F5FA),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFFE0E5EB), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF164CA1), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    } else if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(height: 20),

              // Reason Text Field
              BounceInLeft(
                child: TextField(
                  controller: reasonController,
                  focusNode: _focusNode2,
                  maxLines: 6, // Allow more lines for reason
                  minLines: 3, // Minimum lines to show
                  keyboardType: TextInputType.multiline, // For multi-line input
                  decoration: InputDecoration(
                    labelText: "Reason for Exclusion (Optional)", // Clearer label
                    labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                    hintText: "e.g., 'Do not call', 'Wrong number', 'Customer request'", // More helpful hint
                    hintStyle: GoogleFonts.poppins(fontStyle: FontStyle.italic, color: Colors.grey[500]),
                    filled: true,
                    fillColor: Color(0xFFF0F5FA),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFFE0E5EB), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFF164CA1), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    alignLabelWithHint: true, // Align label to top for multiline
                  ),
                ),
              ),
              SizedBox(height: 30), // Increased spacing before button

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF164CA1), // Brand blue for submit button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // More rounded button
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Larger padding
                    elevation: 5, // Subtle shadow for the button
                    shadowColor: Color(0xFF164CA1).withOpacity(0.4), // Shadow matching button color
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String name = nameController.text;
                      String number = numberController.text;
                      String reason = reasonController.text;

                      // Show a loading indicator or disable button during async operation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Submitting contact...')),
                      );

                      exclude_contacts_service
                          .postExcludeContacts(name, number, reason)
                          .then((response) {
                        if (response['status'] == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Contact excluded successfully!')),
                          );
                          Navigator.pop(context); // Go back after success
                          // Or navigate to userSettings as per original logic if needed
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => userSettings()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to exclude contact: ${response['message'] ?? 'Unknown error'}')),
                          );
                        }
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred: $error')),
                        );
                      });
                    }
                  },
                  child: Text(
                    "Exclude Contact", // More descriptive button text
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, // Semi-bold
                        fontSize: 16, // Larger font
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 40), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}

// Assuming ContactsModel is defined elsewhere, e.g.:
// class ContactsModel {
//   final String? excludedContactName;
//   final String? excludedContactNumber;
//   final String? reason;
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
// }r