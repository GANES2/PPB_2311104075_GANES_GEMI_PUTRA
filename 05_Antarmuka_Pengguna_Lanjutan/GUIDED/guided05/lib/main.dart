import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<dynamic> nama = ["Jarwo", "Furina", "Sietaa"];
List<Color> warna = [Colors.red, Colors.blue, Colors.yellow];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: CustomScrollView(
      slivers: [
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                height: 100,
                width: 100,
                color: warna[index],
                child: Text("${nama[index]}"),
              ),
              childCount: nama.length,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
            )),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            height: 100,
            width: 100,
            color: warna[index],
            child: Text("${nama[index]}"),
          ),
          childCount: nama.length,
        ))
      ],
    )));
  }
}