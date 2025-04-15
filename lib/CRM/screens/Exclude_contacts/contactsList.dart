import 'package:demo787/CRM/Model/contactsModel.dart';
import 'package:demo787/CRM/Services/sharedPreferenceService.dart';
import 'package:demo787/CRM/screens/Exclude_contacts/create_exclude_contacts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/excludeContacts_service.dart';

class Exclude_contact_list extends StatefulWidget {
  const Exclude_contact_list({super.key});

  @override
  State<Exclude_contact_list> createState() => _Exclude_contact_listState();
}

class _Exclude_contact_listState extends State<Exclude_contact_list> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Exclude_contacts_service exclude = Exclude_contacts_service();

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
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "Exclude contacts list",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                        color: Color(0xFF9BC9FF),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Text(
                          "E-Contacts count",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "20",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 75,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Create_exclude_contacts()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          height: screenHeight * 0.075,
                          width: screenWidth * 0.25,
                          child: Text(
                            "Exclude",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF3F6CB3),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        height: screenHeight * 0.075,
                        child: Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        width: screenWidth * 0.25,
                        decoration: BoxDecoration(
                            color: Color(0xFF3F6CB3),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ],
                  )
                ],
              ),
              FutureBuilder<List<ContactsModel>>(
                  future: exclude.get_contacts_list(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}"); // Handle errors
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text(
                          "No Data Available"); // Handle empty data case
                    }
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            height: screenHeight * 0.65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 8),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot
                                    .data![index]; // Get each ContactModel

                                print(snapshot);
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          data.excludedContactName.toString()),
                                      subtitle: Text(data.excludedContactNumber
                                          .toString()),
                                      leading: Icon(Icons.person),
                                      onTap: () {
                                        print("Tapped on: ${data.reason}");
                                      },
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      indent: screenHeight * 0.025,
                                      endIndent: screenHeight * 0.025,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
