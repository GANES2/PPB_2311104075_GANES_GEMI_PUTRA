import 'package:flutter/material.dart';
import 'database_helper.dart';

class FormEdit extends StatefulWidget {
  final Map<String, dynamic> mahasiswa;

  const FormEdit({super.key, required this.mahasiswa});

  @override
  State<FormEdit> createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  late TextEditingController namaController;
  late TextEditingController nimController;
  late TextEditingController alamatController;
  late TextEditingController hobiController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.mahasiswa['nama']);
    nimController = TextEditingController(text: widget.mahasiswa['nim']);
    alamatController = TextEditingController(text: widget.mahasiswa['alamat']);
    hobiController = TextEditingController(text: widget.mahasiswa['hobi']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Biodata Mahasiswa"),
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (namaController.text.isEmpty ||
                  nimController.text.isEmpty ||
                  alamatController.text.isEmpty ||
                  hobiController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Semua field harus diisi!")),
                );
                return;
              }
              await DatabaseHelper().update(widget.mahasiswa['id'], {
                "nama": namaController.text,
                "nim": nimController.text,
                "alamat": alamatController.text,
                "hobi": hobiController.text,
              });

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data berhasil diperbarui!")),
                );

                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Biodata Mahasiswa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: "Nama",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nimController,
              decoration: InputDecoration(
                labelText: "NIM",
                prefixIcon: const Icon(Icons.badge),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                labelText: "Alamat",
                prefixIcon: const Icon(Icons.home),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: hobiController,
              decoration: InputDecoration(
                labelText: "Hobi",
                prefixIcon: const Icon(Icons.sports_soccer),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
