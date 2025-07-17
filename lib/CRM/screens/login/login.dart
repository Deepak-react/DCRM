import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:demo787/CRM/screens/home/bottomNavigation.dart';
import 'package:demo787/CRM/screens/home/home.dart';
import 'package:demo787/CRM/screens/login/authService.dart';
import 'package:demo787/CRM/screens/login/sign_up.dart';
import 'package:demo787/colors.dart'; // Assuming this contains custom color definitions
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts for consistent typography
// import '../../../fonst.dart'; // Keeping this commented as we'll use GoogleFonts directly
// import 'login.dart'; // Self-referential import, usually not needed.

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false; // Not used in the provided logic

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  AuthService authService = AuthService();

  final FocusNode _focusNode0 = FocusNode(); // For Email
  final FocusNode _focusNode1 = FocusNode(); // For Password

  @override
  void dispose() {
    _focusNode0.dispose();
    _focusNode1.dispose();
    emailController.dispose(); // Dispose controllers
    passwordController.dispose();
    super.dispose();
  }

  // _signup() is commented out in original, so keeping it commented.
  // void _signup() async { /* ... existing commented out code ... */ }

  void _validmove(FocusNode currentNode, FocusNode nextNode) {
    if (_formKey.currentState!.validate()) {
      currentNode.unfocus();
      FocusScope.of(context).requestFocus(nextNode);
    }
  }

  List<String> cities = []; // Not used in the provided logic
  bool isLoading = false; // Not used in the provided logic

  void _showCityList(BuildContext context) async {
    if (cities.isEmpty) {
      ListTile(
        title: Text(""),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Width and Height are not directly used in the new layout,
    // using responsive padding/sizing instead where applicable.
    // final Width = MediaQuery.of(context).size.width;
    // final Height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Clean white background
      body: SafeArea( // Ensures content is not obscured by system UI
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Overall horizontal padding
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                SizedBox(height: 100), // Spacing from top

                // Logo
                FadeInDown( // Using FadeInDown for logo entry
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200, // Fixed width for the logo for better control
                      height: 100, // Fixed height
                      child: Image(image: AssetImage("assets/logo2.png"), fit: BoxFit.contain),
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing after logo

                // Login Title
                FadeInUp( // Using FadeInUp for title
                  child: Text(
                    "Welcome Back!", // More engaging title
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Darker text for prominence
                    ),
                  ),
                ),
                Text(
                  "Sign in to continue", // Subtitle
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40), // Spacing before input fields

                // Email Input Field
                BounceInRight(
                  child: TextFormField(
                    controller: emailController,
                    focusNode: _focusNode0,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address", // Use labelText
                      labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                      hintText: "Enter your email", // Clearer hint
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600]), // Icon
                      filled: true,
                      fillColor: Color(0xFFF0F5FA), // Light, subtle background color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12), // More rounded corners
                        borderSide: BorderSide(color: Color(0xFFE0E5EB), width: 1), // Subtle border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF164CA1), width: 2), // Brand blue border on focus
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                    onFieldSubmitted: (_) => _validmove(_focusNode0, _focusNode1), // Auto-move focus
                  ),
                ),
                SizedBox(height: 20), // Spacing between fields

                // Password Input Field
                BounceInLeft(
                  child: TextFormField(
                    controller: passwordController,
                    focusNode: _focusNode1,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password", // Use labelText
                      labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                      hintText: "Enter your password", // Clearer hint
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]), // Icon
                      filled: true,
                      fillColor: Color(0xFFF0F5FA),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFE0E5EB), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF164CA1), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      } else if (value.length < 4) { // Common standard for passwords
                        return 'Password should be at least 4 characters long';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onFieldSubmitted: (_) { // Submit on last field
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus(); // Dismiss keyboard
                        _performLogin();
                      }
                    },
                  ),
                ),
                SizedBox(height: 40), // Spacing before button

                // Login Button
                BounceInUp( // Animation for the button
                  child: SizedBox(
                    width: double.infinity, // Make button full width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF164CA1), // Brand blue color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // More rounded
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16), // Larger tap area
                        elevation: 5, // Subtle shadow
                        shadowColor: Color(0xFF164CA1).withOpacity(0.4), // Shadow matching button color
                      ),
                      onPressed: _performLogin, // Call a separate function for clarity
                      child: Text(
                        "Log In",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, // Semi-bold
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing before signup options

                // "Don't Have an Account?" Text
                FadeInUp( // Animation
                  delay: Duration(milliseconds: 200),
                  child: Text(
                    "Don't Have an Account?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700], // Softer grey
                    ),
                  ),
                ),
                SizedBox(height: 10), // Spacing

                // Sign Up Link
                FadeInUp( // Animation
                  delay: Duration(milliseconds: 400),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => signup()));
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF164CA1), // Brand blue for link
                        decoration: TextDecoration.underline, // Underline for link
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50), // Spacing at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Centralized login logic
  void _performLogin() {
    if (_formKey.currentState!.validate()) {
      String password = passwordController.text;
      String email = emailController.text;

      // Show a temporary snackbar or loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attempting login...')),
      );

      authService.userAuthentication(password, email).then((response) {
        if (response == "Successful") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Successful!')),
          );
          Navigator.pushReplacement( // Use pushReplacement to prevent going back to login
            context,
            MaterialPageRoute(builder: (context) => custom_bottom()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed: $response')), // Show error message
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred during login: $error')),
        );
        log("Login error: $error");
      });
    }
  }
}