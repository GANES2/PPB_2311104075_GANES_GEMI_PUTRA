import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello World",
      home: const MyHomePage(title: "Flutter Hello World Page"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Pertama"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          // Kotak Orange dengan Kotak Biru di tengah
          Container(
            width: 175,
            height: 110,
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 0, 0),
            ),
            child: Center(
              child: Container(
                width: 85,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          // Kotak Merah dengan Kotak Biru di tengah
          Container(
            width: 175,
            height: 110,
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 17, 0),
            ),
            child: Center(
              child: Container(
                width: 85,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
