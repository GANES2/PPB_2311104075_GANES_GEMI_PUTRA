import 'package:flutter/material.dart';
import 'package:guidedd/main.dart';

class secondPage extends StatefulWidget {
  final String title;
  const secondPage({super.key,required this.title});

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Halaman 2"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text("Previous Page"),
            ),
          ],
        ),
      ),
    );
  }
}