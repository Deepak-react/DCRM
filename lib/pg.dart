// // import 'package:flutter/material.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// //
// // class RatingScreen extends StatefulWidget {
// //   @override
// //   _RatingScreenState createState() => _RatingScreenState();
// // }
// //
// // class _RatingScreenState extends State<RatingScreen> {
// //   double _rating = 3.0; // Default rating
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(title: Text("Star Rating Example")),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               "Rate Us:",
// //               style: TextStyle(fontSize: 20),
// //             ),
// //             SizedBox(height: 10),
// //             RatingBar.builder(
// //               initialRating: _rating,
// //               glow: true,
// //               minRating: 1,
// //               itemSize: 20,
// //               direction: Axis.horizontal,
// //
// //               allowHalfRating: true, // Allows half stars
// //               itemCount: 5,
// //               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
// //               itemBuilder: (context, _) => Icon(
// //                 Icons.star,
// //                 color: Colors.amber,
// //                 size: 1,
// //               ),
// //               onRatingUpdate: (rating) {
// //                 setState(() {
// //                   _rating = rating; // Update rating value
// //                 });
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// //
// // class SecondaryPage extends StatefulWidget {
// //   @override
// //   _SecondaryPageState createState() => _SecondaryPageState();
// // }
// //
// // class _SecondaryPageState extends State<SecondaryPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Secondary Page"),
// //         leading: IconButton(
// //           icon: Icon(Icons.menu_open), // Change drawer icon here
// //           onPressed: () {
// //             Scaffold.of(context).openDrawer(); // Opens the drawer manually
// //           },
// //         ),
// //       ),
// //       drawer: Drawer(
// //         child: ListView(
// //           padding: EdgeInsets.zero,
// //           children: [
// //             DrawerHeader(
// //               decoration: BoxDecoration(color: Colors.blue),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   CircleAvatar(
// //                     radius: 30,
// //                     backgroundImage: AssetImage("assets/profile.jpg"),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text("User Name",
// //                       style: TextStyle(color: Colors.white, fontSize: 18)),
// //                   Text("user@example.com",
// //                       style: TextStyle(color: Colors.white70)),
// //                 ],
// //               ),
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.dashboard),
// //               title: Text("Dashboard"),
// //               onTap: () {
// //                 Navigator.pop(context);
// //               },
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.settings),
// //               title: Text("Settings"),
// //               onTap: () {
// //                 // Navigate to settings page
// //               },
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.logout),
// //               title: Text("Logout"),
// //               onTap: () {
// //                 // Handle logout action
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: Center(
// //         child: Text("This is the secondary page with a custom drawer icon."),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class tripposttripbid extends StatefulWidget {
//   const tripposttripbid({super.key});
//
//   @override
//   State<tripposttripbid> createState() => _tripposttripbidState();
// }
//
// class _tripposttripbidState extends State<tripposttripbid> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     double _rating = 3.0;
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: Container(
//         width: 350,
//         child: Drawer(
//           child: Column(
//             children: [
//               Text("data"),
//               buildDrawer(),
//               // ListView.builder(itemBuilder: Builder(builder: (ContextAction)))
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             AppBar(
//               elevation: 3,
//               shadowColor: Colors.grey[50],
//               backgroundColor: Colors.white,
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios_new_outlined,
//                     size: 17,
//                   )),
//               title: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     "Trip Post & Trip Bid",
//                     // style: FontStyles.boldStyle(15.0)
//                   )),
//               actions: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.list,
//                       size: 25,
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.search,
//                       size: 25,
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.more_vert,
//                       size: 25,
//                     )),
//               ],
//             ),
//
//             Container(
//               height: height * 1,
//               width: width * 5,
//               child: ListView.builder(
//                 itemBuilder: (BuildContext context, int index) {
//                   return buildCard();
//                 },
//               ),
//             ),
//             // buildCard()
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCard() {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Flexible(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 5.0, right: 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Material(
//               elevation: 10,
//               borderRadius: BorderRadius.circular(20),
//               child: Container(
//                 height: 300,
//                 width: width * 2.500,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: Colors.white),
//                 child: Column(
//                   children: [
//                     AppBar(
//                       elevation: 10,
//                       toolbarHeight: 30,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15))),
//                       backgroundColor: Colors.grey[400],
//                       leading: Icon(
//                         Icons.perm_identity,
//                         color: Colors.white,
//                       ),
//                       title: Text(
//                         "Defe8EIS",
//                       ),
//                       actions: [
//                         Text(
//                           "29-08-2025",
//                           // style: FontStyles.regularStyle(17.0,
//                           //     color: Colors.white)
//                         ),
//                         Text(
//                           "/ 01:05 PM",
//                           // style: FontStyles.regularStyle(17.0,
//                           //     color: Colors.white)
//                         ),
//                         SizedBox(
//                           width: 8.5,
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       width: 18.5,
//                     ),
//                     // Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.end,
//                     //   mainAxisAlignment: MainAxisAlignment.start,
//                     //   children: [
//                     //     // Repeated Row Widgets
//                     //     Row(
//                     //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Post Type",
//                     //           // style: FontStyles.regularStyle(13),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //         Text(
//                     //           "Trip Amount",
//                     //           // style: FontStyles.regularStyle(13),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Need CAb",
//                     //           //style: FontStyles.boldStyle(15),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //         Text(
//                     //           "1200",
//                     //           // style: FontStyles.boldStyle(15),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Travel Date",
//                     //           // style: FontStyles.regularStyle(13),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //         Text(
//                     //           "Travel Time",
//                     //           //style: FontStyles.regularStyle(13),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "00/00/2024",
//                     //           //style: FontStyles.boldStyle(15),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 115,
//                     //         ),
//                     //         Text(
//                     //           "02:30 AM",
//                     //           // style: FontStyles.boldStyle(15),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       //  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Pickup City",
//                     //           //style: FontStyles.regularStyle(13),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //         Text(
//                     //           "Drop City",
//                     //           //style: FontStyles.regularStyle(13),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       //  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Coimbatore",
//                     //           //style: FontStyles.boldStyle(15),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 115,
//                     //         ),
//                     //         Text(
//                     //           "Coimbatore",
//                     //           //style: FontStyles.boldStyle(15),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Pickup Area",
//                     //           //style: FontStyles.regularStyle(13),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //         Text(
//                     //           "Drop Area",
//                     //           //  style: FontStyles.regularStyle(13),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "Pappanaickenpalayam",
//                     //           // style: FontStyles.boldStyle(15),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 45,
//                     //         ),
//                     //         Text(
//                     //           "Annur-Mattupalayam",
//                     //           //style: FontStyles.boldStyle(15),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       //  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "No of Passengers",
//                     //           //style: FontStyles.regularStyle(13),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     Row(
//                     //       //  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Text(
//                     //           "04",
//                     //           //  style: FontStyles.boldStyle(15),
//                     //         ),
//                     //         SizedBox(
//                     //           width: 130,
//                     //         ),
//                     //         Text(
//                     //           "",
//                     //           // style: FontStyles.regularStyle(13),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ],
//                     // ),
//                     Divider(
//                       indent: 15,
//                       endIndent: 15,
//                       thickness: 0.5,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 4.0),
//                           child: Card(
//                             elevation: 5,
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(10), // Curved edges
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(
//                                   5), // Apply curved edges inside the card
//                               child: Container(
//                                 height: 40,
//                                 width: 80,
//                                 color: Colors.greenAccent[100],
//                                 child: Column(
//                                   children: [
//                                     Flexible(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Total bids',
//                                           // style: FontStyles.regularStyle(11.0,
//                                           //     color: Colors.black),
//                                         ),
//                                       ),
//                                     ),
//                                     Flexible(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           "1231234",
//                                           // style: FontStyles.boldStyle(11.5,
//                                           //     color: Colors.green),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Card 2 with curved edges
//                         Card(
//                           elevation: 5,
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(10), // Curved edges
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                                 5), // Apply curved edges inside the card
//                             child: Container(
//                               height: 40,
//                               width: 80,
//                               color: Colors.deepPurple[50],
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'Avg Amount',
//                                         // style: FontStyles.regularStyle(11.5,
//                                         //     color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         " ₹ 12312",
//                                         // style: FontStyles.boldStyle(11.5,
//                                         //     color: Colors.purple),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Card 3 with curved edges
//                         Card(
//                           elevation: 5,
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(10), // Curved edges
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: Container(
//                               height: 40,
//                               width: 80,
//                               color: Colors.pink[50],
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'Hig Amount',
//                                         // style: FontStyles.regularStyle(11.5,
//                                         //     color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         " ₹ 12314",
//                                         // style: FontStyles.boldStyle(11.5,
//                                         //     color: Colors.pink),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         // Bid Now button with curved edges
//                         SizedBox(
//                           height: 40,
//                           width: 90,
//                           child: Flexible(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 // backgroundColor: button,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       7), // Curved edges for button
//                                 ),
//                               ),
//                               onPressed: () {
//                                 _scaffoldKey.currentState?.openDrawer();
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) => Bidnow()));
//                               },
//                               child: Text(
//                                 "Bid Now",
//                                 // style: FontStyles.boldStyle(11.0,
//                                 //     color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildDrawer() {
//     double _rating = 3.0;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Card(
//           elevation: 5,
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.cyanAccent),
//             borderRadius: BorderRadius.circular(10),
//
//             // Curved edges
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Column(
//               children: [
//                 Container(
//                   height: 35,
//                   width: 390,
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Ratings:",
//                         //  style: FontStyles.regularStyle(15),
//                       ),
//                       RatingBar.builder(
//                         initialRating: 4,
//                         glow: true,
//                         minRating: 1,
//                         itemSize: 15,
//                         direction: Axis.horizontal,
//
//                         allowHalfRating: true, // Allows half stars
//                         itemCount: 5,
//                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                         itemBuilder: (context, _) => Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                         onRatingUpdate: (rating) {
//                           setState(() {
//                             _rating = rating; // Update rating value
//                           });
//                         },
//                       ),
//                       SizedBox(
//                         width: 2,
//                       ),
//                       Text(
//                         "26-06-2024/",
//                         style: TextStyle(fontSize: 15),
//                       ),
//                       Text(
//                         "12:12 PM ",
//                       ),
//                     ],
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Bid Amount : 520"),
//                     )),
//                 Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Comment :"),
//                     )),
//                 Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Loren ipsum is simple dummy text of"),
//                     )),
//                 Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Loren ipsum is simple dummy text of"),
//                     )),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: SizedBox(
//                     // height: Height * 0.050,
//                     // width: Width * 0.400,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                         ),
//                         onPressed: () {
//                           // Navigator.push(
//                           //     context, MaterialPageRoute(builder: (context) => newpass()));
//                         },
//                         child: Text("Accept",
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class pg extends StatefulWidget {
  const pg({super.key});

  @override
  State<pg> createState() => _pgState();
}

class _pgState extends State<pg> {
  //functions for the
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Action"),
          content: const Text("Are you sure you want to proceed?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                print("Confirmed!"); // Perform action
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
            width: 120,
            child: IconButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                icon: Icon(Icons.ac_unit)),
          )
        ],
      ),
    );
  }
}

class BuilderContaxt {}
