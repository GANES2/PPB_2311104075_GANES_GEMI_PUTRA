// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// List<String> nama = ["Jarwo", "Furina", "Sietaa"];
// List<Color> warna = [Colors.red, Colors.blue, Colors.yellow];

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ListView.separated(
//           itemCount: nama.length,
//           itemBuilder: (context, index) => Container(
//             height: 100,
//             width: 100,
//             color: warna[index],
//             alignment: Alignment.center,
//             child: Text(
//               nama[index],
//               style: const TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//           separatorBuilder: (context, index) => const Divider(
//             color: Colors.black,
//             thickness: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }
