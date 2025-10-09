import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rekomendasi Wisata',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const WisataDetail(),
    );
  }
}

class WisataDetail extends StatelessWidget {
  const WisataDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final horizontalPadding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.07; // responsive font size for title
    final descriptionFontSize = screenWidth * 0.045; // responsive font size for description

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rekomendasi Wisata'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Judul tempat wisata
            Text(
              'Baturraden',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.07),
            
            // Gambar dari internet dengan AspectRatio agar responsif
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://1.bp.blogspot.com/-_zqY3NnvyRM/ViI8Fpkw9XI/AAAAAAAAHDw/ONOoPXfN15s/s1600/pintu%2Bmasuk%2Blokawsiata%2Bbaturaden%2Brawalo-ku.bogspot.com.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: screenWidth * 0.07),
            
            // Deskripsi tempat wisata
            Text(
              'Baturraden adalah sebuah objek wisata alam yang terletak di lereng Gunung Slamet, sekitar 15 kilometer dari pusat kota Purwokerto, Kabupaten Banyumas, Jawa Tengah. Terkenal dengan pemandangan alamnya yang indah dan udara yang sejuk, Baturraden menjadi destinasi favorit wisatawan lokal maupun mancanegara.',
              style: TextStyle(fontSize: descriptionFontSize),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: screenWidth * 0.07),
            
            // Tombol Kunjungi Tempat dengan padding responsif
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengunjungi Baturraden!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 12),
              ),
              child: const Text('Kunjungi Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
