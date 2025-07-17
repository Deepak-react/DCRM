import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts for consistent typography
import 'package:flutter_svg/flutter_svg.dart'; // Import if you plan to use SVG placeholders

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadSavedImagePath();
  }

  // 📌 Step 1: Load Saved Image from SharedPreferences
  Future<void> _loadSavedImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');

    if (imagePath != null && File(imagePath).existsSync() && mounted) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  // 📌 Step 2: Pick & Crop Image, Then Save Path
  Future<void> _pickAndCropImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // Square Crop
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: Color(0xFF164CA1), // Brand blue for toolbar
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square, // Ensure square aspect ratio
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: "Crop Image",
            aspectRatioLockEnabled: true,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
        });

        // 📌 Save Cropped Image Path
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('imagePath', croppedFile.path);
      }
    }
  }

  // 📌 Step 3: UI for Selecting and Displaying Image
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Consistent white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a cleaner look
        title: Center(
          child: Text(
            "Profile Picture", // More descriptive title
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          SizedBox(width: 48), // To balance the centered title
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display Area for the Image
            Container(
              width: 180, // Fixed size for the circular avatar
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Circular shape
                color: Color(0xFFE8F4F8), // Light background when no image
                border: Border.all(
                  color: Color(0xFF164CA1).withOpacity(0.3), // Subtle border
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 5), // Soft shadow
                  ),
                ],
              ),
              child: ClipOval( // Clip the image to an oval shape
                child: _selectedImage != null
                    ? Image.file(
                  _selectedImage!,
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover, // Cover the entire circle
                )
                    : Icon(
                  Icons.person_rounded, // Placeholder icon
                  size: 100, // Large icon
                  color: Colors.grey[400], // Soft grey color
                ),
              ),
            ),
            SizedBox(height: 30), // Increased spacing

            // Button to Pick and Crop Image
            ElevatedButton(
              onPressed: _pickAndCropImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF164CA1), // Brand blue background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Generous padding
                elevation: 5, // Subtle shadow
                shadowColor: Color(0xFF164CA1).withOpacity(0.4), // Shadow matching button color
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Wrap content
                children: [
                  Icon(Icons.photo_library, color: Colors.white, size: 22), // Icon
                  SizedBox(width: 10), // Spacing
                  Text(
                    "Change Profile Picture", // More descriptive text
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // Semi-bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}