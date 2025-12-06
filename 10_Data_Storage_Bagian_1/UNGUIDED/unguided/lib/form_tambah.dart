import 'package:flutter/material.dart';
import 'database_helper.dart';

class FormTambah extends StatefulWidget {
  const FormTambah({super.key});

  @override
  State<FormTambah> createState() => _FormTambahState();
}

class _FormTambahState extends State<FormTambah> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController hobiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Biodata Mahasiswa"),
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Optional: Add functionality if needed
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
              "Masukkan Biodata Mahasiswa",
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
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
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
                  await DatabaseHelper().create({
                    'nama': namaController.text,
                    'nim': nimController.text,
                    'alamat': alamatController.text,
                    'hobi': hobiController.text,
                  });

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[700],
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.save),
                label: const Text("Simpan", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
