// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BottomNavWithFAB(),
//     );
//   }
// }
//
// class BottomNavWithFAB extends StatefulWidget {
//   @override
//   _BottomNavWithFABState createState() => _BottomNavWithFABState();
// }
//
// class _BottomNavWithFABState extends State<BottomNavWithFAB> {
//   int _index = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _index = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("Selected Index: $_index")),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         shape: CircleBorder(),
//         elevation: 6,
//         onPressed: () {},
//         child: Icon(Icons.add, color: Colors.white, size: 30),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         color: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(Icons.home, "Home", 0),
//               _buildNavItem(Icons.build, "Service", 1),
//               SizedBox(width: 40), // Space for FAB
//               _buildNavItem(Icons.add, "Post", 2, isCenter: true), // FAB Label
//               _buildNavItem(Icons.credit_card, "Credit", 3),
//               _buildNavItem(Icons.person, "Profile", 4),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String label, int index,
//       {bool isCenter = false}) {
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (!isCenter)
//             Icon(icon, color: _index == index ? Colors.blue : Colors.grey),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: _index == index ? Colors.blue : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1), // Square Crop
        //   cropStyle: CropStyle.rectangle, // Change to CropStyle.circle if needed
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true, // Lock the aspect ratio
          ),
          IOSUiSettings(
            title: "Crop Image",
            aspectRatioLockEnabled: true,
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
      appBar: AppBar(title: Text("Image Picker & Cropper")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!,
                    width: 200, height: 200, fit: BoxFit.cover)
                : Text("No image selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAndCropImage,
              child: Text("Pick and Crop Image"),
            ),
          ],
        ),
      ),
    );
  }
}
