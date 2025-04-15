// import 'package:flutter/material.dart';
//
// class inborn extends StatefulWidget {
//   const inborn({super.key});
//
//   @override
//   State<inborn> createState() => _inbornState();
// }
//
// class _inbornState extends State<inborn> {
//   bool showFirstCard = false;
//   bool showSecondCard = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // ✅ First Button
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 showFirstCard = !showFirstCard;
//                 showSecondCard =
//                     false; // Close second card when first is clicked
//               });
//             },
//             child: Container(
//               height: 50,
//               width: 380,
//               child: ListTile(
//                 title: Text("Show First Data"),
//                 trailing: Icon(
//                   showFirstCard
//                       ? Icons.keyboard_arrow_down
//                       : Icons.arrow_forward_ios,
//                 ),
//               ),
//             ),
//           ),
//
//           if (showFirstCard) ...buildFirstMethodData(),
//
//           // ✅ Second Button
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 showSecondCard = !showSecondCard;
//                 showFirstCard =
//                     false; // Close first card when second is clicked
//               });
//             },
//             child: Container(
//               height: 50,
//               width: 380,
//               child: ListTile(
//                 title: Text("Show Second Data"),
//                 trailing: Icon(
//                   showSecondCard
//                       ? Icons.keyboard_arrow_down
//                       : Icons.arrow_forward_ios,
//                 ),
//               ),
//             ),
//           ),
//
//           if (showSecondCard) ...buildSecondMethodData(),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> buildFirstMethodData() {
//     return [
//       Text(
//         "First Method Data",
//       ),
//       Text(
//         "First Method Data",
//       ),
//     ];
//   }
//
//   List<Widget> buildSecondMethodData() {
//     return [
//       Text(
//         "First Method Data",
//       ),
//       Text(
//         "First Method Data",
//       ),
//     ];
//   }
// }

import 'package:flutter/material.dart';

import 'fonst.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String selectedView = "Open";
  bool _showMore = false;

  // Data mapping based on selected view
  Map<String, Widget Function()> get dataWidgets => {
        "Open": () => _buildCard(),
        "Initiated": () => _buildProgress(),
        "Progress": () =>
            Text("Showing Progress Data", style: TextStyle(fontSize: 18)),
        "Started": () =>
            Text("Showing Started Data", style: TextStyle(fontSize: 18)),
      };

  // Method to get the widget based on selected view
  Widget getSelectedViewWidget() {
    return dataWidgets[selectedView]?.call() ?? Text("No Data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status Selection")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["Open", "Initiated", "Progress", "Started"]
                .map((label) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedView = label;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedView == label
                              ? Colors.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: selectedView == label
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          getSelectedViewWidget(), // Display the selected view data
        ],
      ),
    );
  }

  Widget _buildDefaultDetails() {
    return Column(
      children: [
        _buildRow("Post Type", "Trip Amount"),
        _buildRow("Need Cab", "1200", isBold: true),
        _buildRow("Travel Date", "Travel Time"),
        _buildRow("00/00/2024", "02:30 AM", isBold: true),
        _buildRow("Pickup City", "Drop City"),
        _buildRow("Coimbatore", "Coimbatore", isBold: true),
        _buildRow("No of Passengers", ""),
        _buildRow("04", "", isBold: true),
      ],
    );
  }

  Widget _buildCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 5),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 355, // Fixed height
            width: 380, // Adjusted to fit screen properly
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                AppBar(
                  elevation: 10,
                  toolbarHeight: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  backgroundColor: Colors.grey[400],
                  leading: Icon(Icons.perm_identity, color: Colors.white),
                  title: Text(
                    "Defe8EIS",
                    style: FontStyles.regularStyle(17.0, color: Colors.white),
                  ),
                  actions: [
                    Text(
                      "29-08-2025",
                      style: FontStyles.regularStyle(17.0, color: Colors.white),
                    ),
                    Text(
                      "/ 01:05 PM",
                      style: FontStyles.regularStyle(17.0, color: Colors.white),
                    ),
                    SizedBox(width: 8.5),
                  ],
                ),
                SizedBox(height: 5),

                // Scrollable content inside fixed-height card
                Expanded(
                  child:
                      _showMore ? _buildMoreDetails() : _buildDefaultDetails(),
                ),

                // "Tap for More Details" aligned to right before divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          child: Icon(
                        Icons.ios_share,
                        size: 15,
                      )),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMore = !_showMore;
                          });
                        },
                        child: Text(
                          _showMore ? "View Less" : "Tap for More Details",
                          style:
                              FontStyles.regularStyle(12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(indent: 15, endIndent: 15, thickness: 0.5),

                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 2),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => trippostedit()));
                      },
                      child: Text(
                        "Edit",
                        style: FontStyles.boldStyle(11.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 5),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 355, // Fixed height
            width: 380, // Adjusted to fit screen properly
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                AppBar(
                  elevation: 10,
                  toolbarHeight: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  backgroundColor: Colors.grey[400],
                  leading: Icon(Icons.perm_identity, color: Colors.white),
                  title: Text(
                    "Defe8EIS",
                    style: FontStyles.regularStyle(17.0, color: Colors.white),
                  ),
                  actions: [
                    Text(
                      "29-08-2025",
                      style: FontStyles.regularStyle(17.0, color: Colors.white),
                    ),
                    Text(
                      "/ 01:05 PM",
                      style: FontStyles.regularStyle(17.0, color: Colors.white),
                    ),
                    SizedBox(width: 8.5),
                  ],
                ),
                SizedBox(height: 5),

                // Scrollable content inside fixed-height card
                Expanded(
                  child:
                      _showMore ? _buildMoreProgress() : _buildDefaultDetails(),
                ),

                // "Tap for More Details" aligned to right before divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          child: Icon(
                        Icons.ios_share,
                        size: 15,
                      )),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMore = !_showMore;
                          });
                        },
                        child: Text(
                          _showMore ? "View Less" : "Tap for More Details",
                          style:
                              FontStyles.regularStyle(12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(indent: 15, endIndent: 15, thickness: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, bottom: 2),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => bidacceptstatus()));
                          },
                          child: Text(
                            "Accepted Bid Details",
                            style:
                                FontStyles.boldStyle(11.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18, bottom: 5),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => trippostedit()));
                          },
                          child: Text(
                            "Edit",
                            style:
                                FontStyles.boldStyle(11.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

                // SizedBox(height: ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreDetails() {
    return Column(
      children: [
        _buildRow("Driver Name", "Vehicle Type"),
        _buildRow("John Doe", "SUV", isBold: true),
        _buildRow("Vehicle Number", "Contact"),
        _buildRow("TN 01 AB 1234", "+91 98765 43210", isBold: true),
        _buildRow("Ride Status", "Payment Status"),
        _buildRow("Completed", "Paid", isBold: true),
      ],
    );
  }

  Widget _buildMoreProgress() {
    return Column(
      children: [
        _buildRow("vehicle Model", "Vehicle Category"),
        _buildRow("i20", " SUV", isBold: true),
        _buildRow("Vehicle Capacity", ""),
        _buildRow("4", "", isBold: true),
        _buildRow("Pickup City", ""),
        _buildRow("Comments", "", isBold: true),
        _buildRow(
          "Pickup Area",
          "",
        ),
      ],
    );
  }

  Widget _buildRow(String leftText, String rightText, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              leftText,
              style: isBold
                  ? FontStyles.boldStyle(15)
                  : FontStyles.regularStyle(13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                rightText,
                style: isBold
                    ? FontStyles.boldStyle(15)
                    : FontStyles.regularStyle(13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: StatusScreen()));
}
