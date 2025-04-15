// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class inbor extends StatefulWidget {
// //   const inbor({super.key});
// //
// //   @override
// //   State<inbor> createState() => _inborState();
// // }
// //
// // class _inborState extends State<inbor> {
// //   TextEditingController leftController = TextEditingController();
// //   TextEditingController rightController = TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           buildTextFieldRow(
// //               "leftText", leftController, "rightText", rightController)
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // Widget buildTextFieldRow(
// //   String leftText,
// //   TextEditingController leftController,
// //   String rightText,
// //   TextEditingController rightController, {
// //   bool isLeftIcon = false,
// //   bool isRightIcon = false,
// // }) {
// //   return Padding(
// //     padding: EdgeInsets.symmetric(horizontal: 16.0), // Consistent padding
// //     child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         // Left Text Field
// //         Container(
// //           width: 180, // Adjust based on your UI needs
// //           child: TextFormField(
// //             controller: leftController,
// //             decoration: InputDecoration(
// //               labelText: leftText,
// //               border: OutlineInputBorder(),
// //               suffixIcon:
// //                   isLeftIcon ? Icon(Icons.keyboard_arrow_down_sharp) : null,
// //             ),
// //           ),
// //         ),
// //
// //         // Right Text Field
// //         Container(
// //           width: 180, // Adjust based on your UI needs
// //           child: TextFormField(
// //             controller: rightController,
// //             decoration: InputDecoration(
// //               labelText: rightText,
// //               border: OutlineInputBorder(),
// //               suffixIcon:
// //                   isRightIcon ? Icon(Icons.keyboard_arrow_down_sharp) : null,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
//
// import 'package:flutter/material.dart';
//
// class CorporateCustomersScreen extends StatefulWidget {
//   @override
//   _CorporateCustomersScreenState createState() =>
//       _CorporateCustomersScreenState();
// }
//
// class _CorporateCustomersScreenState extends State<CorporateCustomersScreen> {
//   // TextEditingControllers for fields
//   TextEditingController stateController = TextEditingController();
//   TextEditingController areaController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController pinCodeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Corporate Customers"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTextFieldRow(
//                 "State",
//                 stateController,
//                 "Area Location",
//                 areaController,
//                 isLeftIcon: true,
//                 isRightIcon: true,
//                 onLeftIconPressed: () {
//                   _showBottomSheet(
//                       context, stateController, ["Karnataka", "Maharashtra"]);
//                 },
//                 onRightIconPressed: () {
//                   _showBottomSheet(
//                       context, areaController, ["Bangalore", "Mumbai"]);
//                 },
//               ),
//               SizedBox(height: 16),
//               buildTextFieldRow(
//                 "City",
//                 cityController,
//                 "Pin Code",
//                 pinCodeController,
//                 isLeftIcon: true,
//                 isRightIcon: true,
//                 onLeftIconPressed: () {
//                   _showBottomSheet(
//                       context, cityController, ["Delhi", "Chennai"]);
//                 },
//                 onRightIconPressed: () {
//                   _showBottomSheet(
//                       context, pinCodeController, ["560001", "400001"]);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget to build a row of two text fields
//   Widget buildTextFieldRow(
//     String leftLabel,
//     TextEditingController leftController,
//     String rightLabel,
//     TextEditingController rightController, {
//     bool isLeftIcon = false,
//     bool isRightIcon = false,
//     VoidCallback? onLeftIconPressed,
//     VoidCallback? onRightIconPressed,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Expanded(child: Text(leftLabel, style: TextStyle(fontSize: 16))),
//             Expanded(child: Text(rightLabel, style: TextStyle(fontSize: 16))),
//           ],
//         ),
//         SizedBox(height: 5),
//         Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: leftController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   suffixIcon: isLeftIcon
//                       ? IconButton(
//                           icon: Icon(Icons.keyboard_arrow_down),
//                           onPressed: onLeftIconPressed,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             SizedBox(width: 10),
//             Expanded(
//               child: TextField(
//                 controller: rightController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   suffixIcon: isRightIcon
//                       ? IconButton(
//                           icon: Icon(Icons.keyboard_arrow_down),
//                           onPressed: onRightIconPressed,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Function to show a bottom sheet with options
//   void _showBottomSheet(BuildContext context, TextEditingController controller,
//       List<String> options) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => ListView(
//         children: options.map((option) {
//           return ListTile(
//             title: Text(option),
//             onTap: () {
//               controller.text = option;
//               Navigator.pop(context);
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MultiDropdownScreen extends StatefulWidget {
  @override
  _MultiDropdownScreenState createState() => _MultiDropdownScreenState();
}

class _MultiDropdownScreenState extends State<MultiDropdownScreen> {
  // Controllers for the TextFields
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  // API Call Futures
  Future<List<String>>? _stateOptions;
  Future<List<String>>? _cityOptions;
  Future<List<String>>? _countryOptions;

  @override
  void initState() {
    super.initState();
    _stateOptions = fetchData("https://api.example.com/states");
    _cityOptions = fetchData("https://api.example.com/cities");
    _countryOptions = fetchData("https://api.example.com/countries");
  }

  // Fetch API Data Function
  Future<List<String>> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      return ["Error loading data"];
    }
  }

  // Function to show the Bottom Sheet for Dropdowns
  void _showBottomSheet(BuildContext context, TextEditingController controller,
      Future<List<String>> apiData) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => FutureBuilder<List<String>>(
        future: apiData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }
          return ListView(
            children: snapshot.data!.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  controller.text = option;
                  Navigator.pop(context);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Responsive width

    return Scaffold(
      appBar: AppBar(title: Text("Multi API Dropdowns")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // State Dropdown
            buildDropdownField("State", stateController, _stateOptions),
            SizedBox(height: 10),
            // City Dropdown
            buildDropdownField("City", cityController, _cityOptions),
            SizedBox(height: 10),
            // Country Dropdown
            buildDropdownField("Country", countryController, _countryOptions),
          ],
        ),
      ),
    );
  }

  // Function to Build Dropdown Field with Icon
  Widget buildDropdownField(String label, TextEditingController controller,
      Future<List<String>>? apiData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: () => _showBottomSheet(context, controller, apiData!),
            ),
          ),
        ),
      ],
    );
  }
}
