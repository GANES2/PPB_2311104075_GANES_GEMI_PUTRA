import 'package:flutter/material.dart';

void main() {
  runApp(const TPApp());
}

class TPApp extends StatelessWidget {
  const TPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TP Modul 09',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
      ),
      home: const TPHomePage(),
    );
  }
}

class TPHomePage extends StatelessWidget {
  const TPHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Pendahuluan - Modul 09'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // PREVIEW AREA
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueGrey.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image_outlined, size: 96),
                    SizedBox(height: 12),
                    Text(
                      'Preview Gambar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 16),

            // BUTTON AREA
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: null, // belum berfungsi (TP)
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Pilih dari Galeri'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: null, // belum berfungsi (TP)
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Ambil dari Kamera'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: null, // belum berfungsi (TP)
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus Gambar'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Catatan:\nTombol belum dihubungkan ke\nfungsi Camera dan Gallery.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
