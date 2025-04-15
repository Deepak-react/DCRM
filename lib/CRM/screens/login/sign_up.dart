import 'package:animate_do/animate_do.dart';
import 'package:demo787/colors.dart';
import 'package:flutter/material.dart';
import '../../../fonst.dart';
import 'login.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;

  final TextEditingController companyController = TextEditingController();
  final TextEditingController companypersonname = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final FocusNode _focusNode0 = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();

  void dispose() {
    // var_const.companyController.dispose();
    // var_const.companypersonnameController.dispose();
    // var_const.passwordController.dispose();
    // var_const.emailController.dispose();
    // var_const.mobileController.dispose();
    // var_const.cityController.dispose();
    // var_const.usernameController.dispose();
    _focusNode0.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    _focusNode7.dispose();
    super.dispose();
  }

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

    @override
    void initState() {
      super.initState();
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cities[index]),
                    onTap: () {
                      cityController.text = cities[index];
                      Navigator.pop(context);
                    },
                  );
                },
              );
      },
    );
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
                  height: 20,
                ),
                Image(image: AssetImage("assets/logo2.png")),
                Center(
                    child: Text("Create a new account",
                        style: FontStyles.numansStyle_black(20))),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: companyController,
                  keyboardType: TextInputType.name,
                  focusNode: _focusNode0,
                  decoration: InputDecoration(
                    hintText: "company Name",
                    hintStyle: FontStyles.hinttext(15),
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
                      return 'Please enter your Company name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onFieldSubmitted: (_) => _validmove(_focusNode0, _focusNode1),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: companypersonname,
                  keyboardType: TextInputType.name,
                  focusNode: _focusNode1,
                  decoration: InputDecoration(
                    hintText: "Company person Name",
                    hintStyle: FontStyles.hinttext(15),
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
                      return 'Please enter your Company name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onFieldSubmitted: (_) => _validmove(_focusNode1, _focusNode2),
                ),
                SizedBox(
                  height: 20,
                ),
                BounceInRight(
                  child: TextFormField(
                    controller: emailController,
                    focusNode: _focusNode2,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      hintStyle: FontStyles.hinttext(15),
                      // Enables background color
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
                    onFieldSubmitted: (_) =>
                        _validmove(_focusNode2, _focusNode3),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BounceInLeft(
                  child: TextFormField(
                    controller: passwordController,
                    focusNode: _focusNode3,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: FontStyles.hinttext(15),
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
                      } else if (value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onFieldSubmitted: (_) =>
                        _validmove(_focusNode3, _focusNode4),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BounceInRight(
                  child: TextFormField(
                    controller: mobileController,
                    focusNode: _focusNode4,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                      hintStyle: FontStyles.hinttext(15),
                      filled: true, // Enables background color
                      fillColor: Colors.grey[350], // Background color
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Fully circular
                        borderSide: BorderSide.none, // No border line
                      ), // Removes underline/border
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
                        return 'Please enter your Mobile Number';
                      } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onFieldSubmitted: (_) =>
                        _validmove(_focusNode4, _focusNode5),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BounceInLeft(
                  child: TextFormField(
                    controller: usernameController,
                    focusNode: _focusNode6,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      hintStyle: FontStyles.hinttext(15),
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
                        return 'Please enter your User Name';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onFieldSubmitted: (_) =>
                        _validmove(_focusNode6, _focusNode7),
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: background2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: BorderSide(
                        width: 1,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: Height * 0.035,
                            width: Width * 0.709,
                            child: Center(
                              child: Text("SIGN UP",
                                  style: FontStyles.boldStyle(15.0,
                                      color: Colors.white)),
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
                  "Already have an account?",
                  style: FontStyles.hinttext(17, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  },
                  child: Text(
                    "Login",
                    style: FontStyles.hinttext(20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _cardtextfeild(controller, focusNode, String hintname, validator) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintname,
        hintStyle: FontStyles.hinttext(15),
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
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your User Name';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (_) => _validmove(_focusNode6, _focusNode7),
    );
  }
}
