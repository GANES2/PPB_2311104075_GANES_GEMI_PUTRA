import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Warna untuk setiap halaman
  final List<Color> _pageColors = [
    const Color(0xFF2196F3), // Biru untuk Beranda
    const Color(0xFF4CAF50), // Hijau untuk Wisata
    const Color(0xFF9C27B0), // Ungu untuk Profile
  ];



  final List<Widget> _pages = [
    // Halaman Beranda
    _buildPageContent(
      title: 'Latihan BottomNavigationBar',
      time: '22.0',
      content: 'Ini Halaman Beranda',
      color: Color(0xFF2196F3),
      lightColor: Color(0xFFE3F2FD),
    ),

    // Halaman Wisata
    _buildPageContent(
      title: 'Latihan BottomNavigationBar',
      time: '22.8',
      content: 'Ini Halaman Wisata',
      color: Color(0xFF4CAF50),
      lightColor: Color(0xFFE8F5E8),
    ),

    // Halaman Profile
    _buildPageContent(
      title: 'Latihan BottomNavigationBar',
      time: '22.8',
      content: 'Ini Halaman Profile',
      color: Color(0xFF9C27B0),
      lightColor: Color(0xFFF3E5F5),
    ),
  ];

  static Widget _buildPageContent({
    required String title,
    required String time,
    required String content,
    required Color color,
    required Color lightColor,
  }) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan title dan time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Garis pemisah
              Container(
                height: 1,
                color: Colors.grey[300],
              ),

              const SizedBox(height: 20),

              // Konten utama
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              // Container dengan warna
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _getIconForContent(content),
                      size: 40,
                      color: color,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Footer text
              const Center(
                child: Text(
                  'Flutter BottomNavigationBar Example',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _getIconForContent(String content) {
    if (content.contains('Beranda')) return Icons.home;
    if (content.contains('Wisata')) return Icons.explore;
    if (content.contains('Profile')) return Icons.person;
    return Icons.help;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: _pageColors[_selectedIndex],
          unselectedItemColor: Colors.grey[600],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Wisata',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
