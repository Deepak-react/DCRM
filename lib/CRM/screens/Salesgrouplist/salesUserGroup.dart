import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    bool isCrown = false;

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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 20, color: Colors.black),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 100),
                child: Text(
                  "User list",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: screenHeight,
              width: screenWidth,
              child: ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                          trailing: SvgPicture.asset(
                            "assets/crown.svg",
                            width: 20,
                            height: 20,
                          ),
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
                            style: GoogleFonts.poppins(
                                color: Color(0xFF3B3D42),
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          subtitle: Text("Id: #5436",
                              style: TextStyle(
                                color: Color(0xFF164CA1),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ))),
                      Divider(
                        thickness: 0.5,
                        endIndent: 10,
                        indent: 70,
                      )
                    ],
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
