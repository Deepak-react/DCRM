import 'package:animate_do/animate_do.dart';
import 'package:demo787/CRM/Services/excludeContacts_service.dart';
import 'package:demo787/CRM/screens/userSettings/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../fonst.dart';
import '../../Model/contactsModel.dart';

class Create_exclude_contacts extends StatefulWidget {
  const Create_exclude_contacts({super.key});

  @override
  State<Create_exclude_contacts> createState() =>
      _Create_exclude_contactsState();
}

class _Create_exclude_contactsState extends State<Create_exclude_contacts> {
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Exclude_contacts_service exclude_contacts_service =
      Exclude_contacts_service();

  final FocusNode _focusNode0 = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  void dispose() {
    _focusNode0.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();

    super.dispose();
  }

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
                    "E-Contacts Form",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      BounceInRight(
                        child: TextFormField(
                          controller: nameController,
                          focusNode: _focusNode0,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Name",
                            filled: true, // Enables background color
                            fillColor: Colors.grey[350], // Background color
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BounceInLeft(
                        child: TextFormField(
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          focusNode: _focusNode1,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "Phone",
                            filled: true, // Enables background color
                            fillColor: Colors.grey[350], // Background color

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10 || value.length > 10) {
                              return 'Please enter an valid phone number';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // onFieldSubmitted: (_) =>
                          //     _validmove(_focusNode3, _focusNode4),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BounceInLeft(
                        child: Container(
                          height: screenHeight * 0.3,
                          child: TextField(
                            controller: reasonController,
                            focusNode: _focusNode2,
                            maxLines: 5,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: "Reason ",
                              filled: true, // Enables background color
                              fillColor: Colors.grey[350], // Background color

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                            ),
                            // onFieldSubmitted: (_) =>
                            //     _validmove(_focusNode3, _focusNode4),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3F6CB3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String name = nameController.text;
                              String number = numberController.text;
                              String reason = reasonController.text;
                              exclude_contacts_service
                                  .postExcludeContacts(name, number, reason)
                                  .then((response) {
                                if (response['status'] == 200) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              userSettings()));
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Validation Successful!')),
                                );
                              });
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => custom_bottom()));
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _formKey {}
