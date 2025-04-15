// import 'package:flutter/material.dart';
//
// import '../../colors.dart';
// import '../../fonst.dart';
//
// class page1 extends StatefulWidget {
//   const page1({super.key});
//
//   @override
//   State<page1> createState() => _page1State();
// }
//
// class _page1State extends State<page1> {
//   bool isSelected = false;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [, background,],
//             begin: Alignment.bottomLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               AppBar(
//                 backgroundColor: Colors.transparent,
//                 actions: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                         onTap: () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => welcome()));
//                         },
//                         child:
//                             Text("Skip", style: FontStyles.regularStyle(17))),
//                   )
//                 ],
//               ),
//               SizedBox(height: height * 0.120),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   child: Image(image: AssetImage("assets/logo.png")),
//                 ),
//               ),
//               SizedBox(height: height * 0.1150),
//               SizedBox(height: height * 0.160),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
