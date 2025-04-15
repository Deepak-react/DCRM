import 'package:flutter/material.dart';

class FontStyles {
  // Regular Roboto Style
  static TextStyle regularStyle(double fontSize, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle regularStyle1(double fontSize,
      {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle numansStyle_gray(double fontSize,
      {Color color = Colors.grey}) {
    return TextStyle(
      fontFamily: 'Numans',
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  static TextStyle numansStyle_black(double fontSize,
      {Color color = Colors.grey}) {
    return TextStyle(
      fontFamily: 'Numans',
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  static TextStyle numansStyle_gray2(double fontSize,
      {Color color = Colors.grey}) {
    return TextStyle(
      fontFamily: 'Numans',
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      color: Colors.black,
    );
  }
  // Customize as needed

  // Bold Roboto Style
  static TextStyle boldStyle(double fontSize, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle SemiBoldStyle1(double fontSize,
      {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  // Italic Roboto Style
  static TextStyle italicStyle(double fontSize, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      color: color,
    );
  }

  static TextStyle hinttext(double fontSize, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle italicStyle2(double fontSize, {Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      color: color,
    );
  }
}
