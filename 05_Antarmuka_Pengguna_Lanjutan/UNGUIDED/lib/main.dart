import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rekomendasi Wisata Area Banyumas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const WisataList(),
    );
  }
}

class Wisata {
  final String nama;
  final String gambarAsset;
  final String deskripsiSingkat;

  Wisata({
    required this.nama,
    required this.gambarAsset,
    required this.deskripsiSingkat,
  });
}

final List<Wisata> daftarWisata = [
  Wisata(
    nama: 'Baturraden',
    gambarAsset: 'assets/images/baturraden.png',
    deskripsiSingkat: 'Objek wisata alam dengan pemandangan indah dan udara sejuk. Cocok untuk hiking dan menikmati panorama.',
  ),
  Wisata(
    nama: 'Curug Cipendok',
    gambarAsset: 'assets/images/curugcipendok.png',
    deskripsiSingkat: 'Air terjun eksotis dengan ketinggian 42 meter dikelilingi hutan tropis yang asri.',
  ),
  Wisata(
    nama: 'Goa Lawa',
    gambarAsset: 'assets/images/GowaLawa.png',
    deskripsiSingkat: 'Goa alami dengan stalaktit dan stalagmit menakjubkan. Tempat eksplorasi bawah tanah.',
  ),
  Wisata(
    nama: 'Telaga Sunyi',
    gambarAsset: 'assets/images/telagasunyi.png',
    deskripsiSingkat: 'Danau tenang dengan air jernih dan suasana damai. Cocok untuk piknik keluarga.',
  ),
  Wisata(
    nama: 'Pancuran Pitu',
    gambarAsset: 'assets/images/pancuranpitu.png',
    deskripsiSingkat: 'Air terjun dengan tujuh pancuran spektakuler dikelilingi hutan hijau.',
  ),
  Wisata(
    nama: 'Waduk Sempor',
    gambarAsset: 'assets/images/waduksempor.png',
    deskripsiSingkat: 'Waduk besar dengan pemandangan luas. Cocok untuk olahraga air dan rekreasi.',
  ),
  Wisata(
    nama: 'Kebun Raya Baturraden',
    gambarAsset: 'assets/images/kebunrayabatturaden.png',
    deskripsiSingkat: 'Kebun botani dengan koleksi tanaman langka. Ideal untuk belajar dan bersantai.',
  ),
  Wisata(
    nama: 'Museum Banyumas',
    gambarAsset: 'assets/images/musiumwayangbbanyumas.png',
    deskripsiSingkat: 'Museum menyimpan sejarah dan budaya Banyumas. Cocok untuk wisata edukasi.',
  ),
];

class WisataList extends StatefulWidget {
  const WisataList({super.key});

  @override
  _WisataListState createState() => _WisataListState();
}

class _WisataListState extends State<WisataList> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }

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
        title: const Text('Rekomendasi Wisata Area Banyumas'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wisataareabanyumas.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5), // Overlay for better text visibility
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Memuat Rekomendasi Wisata...',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Mencari tempat terbaik di Banyumas untuk Anda!',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16.0),
              itemCount: daftarWisata.length,
              itemBuilder: (context, index) {
                final wisata = daftarWisata[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Nama Tempat Wisata
                        Text(
                          wisata.nama,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenWidth * 0.05),
                        // Gambar dari asset dengan AspectRatio agar responsif
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              wisata.gambarAsset,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.05),
                        // Deskripsi singkat tempat wisata
                        Text(
                          wisata.deskripsiSingkat,
                          style: TextStyle(fontSize: descriptionFontSize),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: screenWidth * 0.05),
                        // Tombol Kunjungi Tempat dengan padding responsif
                        ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol ditekan
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Mengunjungi ${wisata.nama}!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Kunjungi Tempat'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
