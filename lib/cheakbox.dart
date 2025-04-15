import 'package:flutter/material.dart';

class MultiCheckboxExample extends StatefulWidget {
  @override
  _MultiCheckboxExampleState createState() => _MultiCheckboxExampleState();
}

class _MultiCheckboxExampleState extends State<MultiCheckboxExample> {
  List<String> checkboxLabels = [
    "Accept Terms & Conditions",
    "Subscribe to Newsletter",
    "Enable Notifications"
  ];

  List<bool> isCheckedList = [
    false,
    false,
    false,
    false,
    false
  ]; // State for each checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multiple Checkboxes")),
      body: ListView.builder(
        itemCount: checkboxLabels.length,
        itemBuilder: (context, index) {
          return buildCheckbox(
            checkboxLabels[index],
            isCheckedList[index],
            (value) {
              setState(() {
                isCheckedList[index] = value;
              });
            },
          );
        },
      ),
    );
  }

  Widget buildCheckbox(String text, bool isChecked, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          checkColor: Colors.white,
          activeColor: Colors.blue,
          onChanged: (bool? value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
        Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
