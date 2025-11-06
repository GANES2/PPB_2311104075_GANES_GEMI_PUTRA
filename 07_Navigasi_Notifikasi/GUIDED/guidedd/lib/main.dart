import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guidedd/model/model.dart';
import 'package:guidedd/pages/secoundPages.dart';

void main() {
  runApp(MyApp());
}

Future<void> loadJsonData() async {
  final String response = await rootBundle.loadString("lib/model/model.json");
  final data = json.decode(response);
  Album album = Album.fromJson(data);
  print(album.title);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    loadJsonData();
    // TODO: implement build
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          Text("Halaman 1"),
          ElevatedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => secondPage(title: "Halaman 2",)));
          }, child: Text("Next Page")),
          ],
        )));
    
  }
}