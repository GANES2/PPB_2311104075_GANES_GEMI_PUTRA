import 'package:flutter/material.dart';
import 'package:guided/connection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Connection();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Insert
            ElevatedButton(
              onPressed: () {
                insertData({'nama': 'Andi', 'gaji': 10000});
              },
              child: Text('Tambah Data'),
            ),
            // Get
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text('Get Data'),
            ),
            // Update
            ElevatedButton(
              onPressed: () {
                updateData({'id': 1, 'nama': 'Budi', 'gaji': 20000});
              },
              child: Text('Update Data'),
            ),
            // Delete
            ElevatedButton(
              onPressed: () {
                deleteData(2);
              },
              child: Text('Delete Data'),
            ),
          ],
        ),
      ),
    );
  }
}