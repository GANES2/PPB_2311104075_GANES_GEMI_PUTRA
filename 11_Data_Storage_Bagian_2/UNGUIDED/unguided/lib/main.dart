import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rnqnokzhtskoydgzdybr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJucW5va3podHNrb3lkZ3pkeWJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQwNDc0MDIsImV4cCI6MjA3OTYyMzQwMn0.hMmKCCmQ0w0Q7nL5GeoHnSv9jwVNHNXO2KjuSsC6Exw',
  );

  runApp(const MyApp());
}

class Book {
  final String id;
  final String judul;
  final String penulis;
  final int tahunTerbit;
  final String genre;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tahunTerbit,
    required this.genre,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      judul: json['judul'],
      penulis: json['penulis'],
      tahunTerbit: json['tahun_terbit'],
      genre: json['genre'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'penulis': penulis,
      'tahun_terbit': tahunTerbit,
      'genre': genre,
    };
  }
}

class LibraryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> createBook(Book book) async {
    await _supabase.from('perpustakaan').insert(book.toJson());
  }

  Future<List<Book>> readBooks() async {
    final response = await _supabase
        .from('perpustakaan')
        .select('*')
        .order('created_at', ascending: false);

    return (response as List).map((json) => Book.fromJson(json)).toList();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LibraryHomePage(),
    );
  }
}

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final LibraryService _libraryService = LibraryService();
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _initializeLibrary();
  }

  Future<void> _initializeLibrary() async {
    // Create sample books
    await _createSampleBooks();

    // Read and display books
    await _readAndDisplayBooks();
  }

  Future<void> _createSampleBooks() async {
    try {
      final sampleBooks = [
        Book(
          id: '',
          judul: 'Flutter for Beginners',
          penulis: 'John Doe',
          tahunTerbit: 2023,
          genre: 'Programming',
          createdAt: DateTime.now(),
        ),
        Book(
          id: '',
          judul: 'Dart Programming',
          penulis: 'Jane Smith',
          tahunTerbit: 2022,
          genre: 'Programming',
          createdAt: DateTime.now(),
        ),
        Book(
          id: '',
          judul: 'Mobile App Development',
          penulis: 'Bob Johnson',
          tahunTerbit: 2021,
          genre: 'Technology',
          createdAt: DateTime.now(),
        ),
      ];

      for (final book in sampleBooks) {
        await _libraryService.createBook(book);
        print('Buku berhasil ditambahkan: ${book.judul}');
      }
    } catch (e) {
      print('Error creating books: $e');
    }
  }

  Future<void> _readAndDisplayBooks() async {
    try {
      _books = await _libraryService.readBooks();

      print('\n=== DATA BUKU DI PERPUSTAKAAN ===');
      for (final book in _books) {
        print('ID: ${book.id}');
        print('Judul: ${book.judul}');
        print('Penulis: ${book.penulis}');
        print('Tahun Terbit: ${book.tahunTerbit}');
        print('Genre: ${book.genre}');
        print('Dibuat pada: ${book.createdAt}');
        print('---');
      }
      print('Total buku: ${_books.length}');

      setState(() {});
    } catch (e) {
      print('Error reading books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Digital'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Data buku telah ditampilkan di console/terminal'),
            const SizedBox(height: 20),
            Text(
              'Total Buku: ${_books.length}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _readAndDisplayBooks,
              child: const Text('Refresh Data'),
            ),
          ],
        ),
      ),
    );
  }
}
