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
  bool _isExpanded = false; // Controls expansion state

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
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => custom_bottom()));
                  },
                  icon: Icon(Icons.arrow_back_ios_new,
                      size: 20, color: Colors.black),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: ListTile(
                      leading: SvgPicture.asset(
                        "assets/user1.svg",
                        width: 50,
                        height: 50,
                      ),
                      title: Text("Sal#01554",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey)),
                      subtitle: Text("Deepak_Yeager",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Account",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              FutureBuilder<List<userData>>(
                future: UserSettingService()
                    .userTileData(), // Fetch data asynchronously
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}"); // Handle errors
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text("No Data Available"); // Handle empty data case
                  }

                  return Column(
                    children: snapshot.data!.map((data) {
                      // Use map to iterate over data
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 7, left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    color: Color(0xFFF0F0F0))
                              ],
                              border: Border.all(
                                  width: 2, color: Color(0xFFF0F0F0))),
                          child: ListTile(
                            title: Text(data.label,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF3B3D42))),
                            subtitle: Text(data.value,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3B3D42))),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "General",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(2, 2), color: Color(0xFFF0F0F0))
                      ],
                      border: Border.all(width: 2, color: Color(0xFFF0F0F0))),
                  child: ListTile(
                    title: Text(
                      "Exclude contacts",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3B3D42)),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Exclude_contact_list()));
                        },
                        icon: Icon(Icons.arrow_right_sharp)),
                  ),
                ),
              ),

              // InkWell(
              //   onTap: () {},
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(12),
              //           boxShadow: [
              //             BoxShadow(
              //                 offset: Offset(2, 2), color: Color(0xFFF0F0F0))
              //           ],
              //           border: Border.all(width: 2, color: Color(0xFFF0F0F0))),
              //       child: ListTile(
              //         title: Text("Exclude contacts",
              //             style: GoogleFonts.poppins(
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xFF3B3D42))),
              //       ),
              //     ),
              //   ),
              // )

              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       _isExpanded = !_isExpanded; // Toggle expansion
              //     });
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //         top: 7, left: 10, right: 10, bottom: 10),
              //      // child: AnimatedContainer(
              //     //   duration: Duration(milliseconds: 300), // Animation duration
              //     //   curve: Curves.easeInOut, // Smooth animation curve
              //     //   height: _isExpanded
              //     //       ? screenHeight * 0.2
              //     //       : screenHeight * 0.075, // Expanded/Collapsed height
              //     //   decoration: BoxDecoration(
              //     //     color: Colors.white,
              //     //     borderRadius: BorderRadius.circular(12),
              //     //     boxShadow: [
              //     //       BoxShadow(
              //     //           offset: Offset(2, 2), color: Color(0xFFF0F0F0))
              //     //     ],
              //     //     border: Border.all(width: 2, color: Color(0xFFF0F0F0)),
              //     //   ),
              //     //   child: Column(
              //     //     children: [
              //     //       ListTile(
              //     //         title: Text(
              //     //           "Exclude contacts",
              //     //           style: GoogleFonts.poppins(
              //     //             fontSize: 15,
              //     //             fontWeight: FontWeight.w500,
              //     //             color: Color(0xFF3B3D42),
              //     //           ),
              //     //         ),
              //     //         trailing: Icon(
              //     //           _isExpanded
              //     //               ? Icons.keyboard_arrow_up
              //     //               : Icons.keyboard_arrow_down,
              //     //         ),
              //     //       ),
              //     //
              //     //       // Hidden content that expands
              //     //       Column(
              //     //         children: [
              //     //           Visibility(
              //     //             visible: _isExpanded,
              //     //             child: Container(
              //     //               height: screenHeight * 0.1,
              //     //               child: Padding(
              //     //                 padding: const EdgeInsets.all(10.0),
              //     //                 child: Column(
              //     //                   crossAxisAlignment:
              //     //                       CrossAxisAlignment.start,
              //     //                   children: [
              //     //                     Text("Hidden Data 1",
              //     //                         style: TextStyle(fontSize: 14)),
              //     //                     SizedBox(height: 5),
              //     //                   ],
              //     //                 ),
              //     //               ),
              //     //             ),
              //     //           ),
              //     //         ],
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //
              //     child: Container(),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }

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

class userData {
  final String label;
  final String value;
  userData({required this.label, required this.value});
}
