import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

TextEditingController inputanNama = TextEditingController();
TextEditingController inputanPassword = TextEditingController();
String nama = "";
int password = 0;
int currentIndex = 0;
int? item = 1;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
        body: _getPage(currentIndex),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputanNama,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukan Nama...",
              ),
            ),
            TextField(
              controller: inputanPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukan Password...",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  nama = inputanNama.text;
                  try {
                    password = int.parse(inputanPassword.text);
                  } catch (e) {
                    password = 0; // Default to 0 if parsing fails
                  }
                });
              },
              child: Text("Submit"),
            ),
            Text(nama),
            Text("$password"),
          ],
        );
      case 1:
        return Column(
          children: [
            Text("DropDown Button", style: GoogleFonts.poppins()),
            DropdownButton(
              value: item,
              items: [
                DropdownMenuItem(value: 1, child: Text("Jakarta")),
                DropdownMenuItem(value: 2, child: Text("Tegal")),
                DropdownMenuItem(value: 3, child: Text("Bandung")),
              ],
              onChanged: (value) {
                setState(() {
                  item = value;
                });
              },
            ),
          ],
        );
      case 2:
        return Text("Settings");
      default:
        return Text("Home");
    }
  }
}
