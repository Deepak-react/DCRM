import 'package:demo787/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Salesgrouplist/salesUserGroup.dart';

class salesGroup extends StatefulWidget {
  const salesGroup({super.key});

  @override
  State<salesGroup> createState() => _salesGroupState();
}

class _salesGroupState extends State<salesGroup> {
  bool isBlob = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final salesRank = [
      salesRankData(
          values: 1, height: screenHeight * 0.075, image: "assets/user1.svg"),
      salesRankData(
          values: 2, height: screenHeight * 0.15, image: "assets/user2.svg"),
      salesRankData(
          values: 3, height: screenHeight * 0.2, image: "assets/user3.svg"),
    ];

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(icon: SvgPicture.asset("assets/call.svg")),
      //   BottomNavigationBarItem(icon: SvgPicture.asset("assets/call.svg")),
      //   BottomNavigationBarItem(icon: SvgPicture.asset("assets/call.svg"))
      // ]),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.black,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: Icon(Icons.keyboard_arrow_left_outlined, size: 20),
              title: Text("Sales Group"),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                height: screenHeight * 0.3,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: salesRank.map((rank) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            rank.image,
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.04,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12)),
                              color: Color(0xFFD2EBCD),
                            ),
                            width: screenWidth * 0.15,
                            height: rank.height,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  rank.values.toString(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      );
                    }).toList()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: screenHeight * 0.465,
              width: screenWidth * 0.9,
              child: ScrollConfiguration(
                behavior: ScrollBehavior()
                    .copyWith(overscroll: false, scrollbars: false),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              isBlob = !isBlob;
                            });
                          },
                          child: salesGroupList());
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget salesGroupList() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          shadowColor: Color(0xFF164CA1),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => salesUserList()));
            },
            child: Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.88,
              decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Color(0xFF164CA1), // Border color
                  //   width: 3, // Border width
                  // ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Color(0xFF164CA1), // Shadow same as border
                  //     offset: Offset(2, 2), // Moves the shadow (X, Y)
                  //     blurRadius: 0, // No blur, just offset
                  //   ),
                  // ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Material(
                    color: Color(0xFF3F6CB3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    elevation: 3,
                    child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 1, color: Color(0xFF9BC9FF))),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFD6F2FB),
                            child: SvgPicture.asset(
                              "assets/salesGroup.svg",
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        title: Text(
                          "Team CRMx",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        subtitle: Text("Team CRMx",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  listCardDetails("Group leader", "Rishi"),
                  listCardDetails("Best performance", "Vignesh"),
                  listCardDetails("Total call", "250 "),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget listCardDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                label,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
              )),
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}

class salesRankData {
  final int values;
  final double height;
  final String image;

  salesRankData({
    required this.values,
    required this.height,
    required this.image,
  });
}
