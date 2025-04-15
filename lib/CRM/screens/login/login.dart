import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:demo787/CRM/screens/home/bottomNavigation.dart';
import 'package:demo787/CRM/screens/home/home.dart';
import 'package:demo787/CRM/screens/login/authService.dart';
import 'package:demo787/CRM/screens/login/sign_up.dart';
import 'package:demo787/colors.dart';
import 'package:flutter/material.dart';
import '../../../fonst.dart';

import 'login.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  AuthService authService = AuthService();

  final FocusNode _focusNode0 = FocusNode();
  final FocusNode _focusNode1 = FocusNode();

  void dispose() {
    _focusNode0.dispose();
    _focusNode1.dispose();

    super.dispose();
  }

  // _signup() async {
  //   try {
  //     print("API posting...");
  //     final response = await https.post(
  //       Uri.parse("http://43.225.167.22:8091/api/signup"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "companyName": companyController.text,
  //         "companyPersonName": companypersonname.text,
  //         "emailAddress": emailController.text,
  //         "mobileNumber": mobileController.text,
  //         "city": cityController.text,
  //         "userName": usernameController.text,
  //         "password": passwordController.text,
  //       }),
  //     );
  //
  //     log(response.body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("User Created Successfully");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const login()),
  //       );
  //     } else {
  //       print("Error: ${response.statusCode}, ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  void _validmove(FocusNode currentNode, FocusNode nextNode) {
    if (_formKey.currentState!.validate()) {
      currentNode.unfocus();
      FocusScope.of(context).requestFocus(nextNode);
    }
  }

  List<String> cities = [];
  bool isLoading = false;

  void _showCityList(BuildContext context) async {
    if (cities.isEmpty) {
      ListTile(
        title: Text(""),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [Colors.white], // Green to White gradient
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Image(image: AssetImage("assets/logo2.png")),
                  ),
                ),
                Center(child: Text("Login", style: FontStyles.boldStyle(20))),
                SizedBox(
                  height: 25,
                ),
                BounceInRight(
                  child: TextFormField(
                    controller: emailController,
                    focusNode: _focusNode0,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onFieldSubmitted: (_) =>
                    //     _validmove(_focusNode2, _focusNode3),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BounceInLeft(
                  child: TextFormField(
                    controller: passwordController,
                    focusNode: _focusNode1,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      } else if (value.length < 4) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onFieldSubmitted: (_) =>
                    //     _validmove(_focusNode3, _focusNode4),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: background2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      side: BorderSide(
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => custom_bottom()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String password = passwordController.text;
                              String email = emailController.text;
                              authService
                                  .userAuthentication(password, email)
                                  .then((response) {
                                if (response == "Successful") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => custom_bottom()),
                                  );
                                }
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Validation Successful!')),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: Height * 0.035,
                              width: Width * 0.609,
                              child: Center(
                                child: Text("Log in",
                                    style: FontStyles.boldStyle(15.0,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Don't Have an Account?",
                  style: FontStyles.hinttext(15, color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signup()));
                  },
                  child: Text(
                    "Sign Up",
                    style: FontStyles.regularStyle(20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
