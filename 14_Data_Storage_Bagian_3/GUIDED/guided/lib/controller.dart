import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://api.example.com"; // Ganti dengan API URL Anda

  List post = [];

  // GET - Ambil semua data
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/data'));

      if (response.statusCode == 200) {
        post = jsonDecode(response.body) as List;
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // POST - Tambah data
  Future<void> postData(String name, String nim) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'nim': nim}),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Gagal menambah data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // PUT - Update data
  Future<void> updateData(String id, String name, String nim) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/data/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'nim': nim}),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal mengupdate data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // DELETE - Hapus data
  Future<void> deleteData(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/data/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal menghapus data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
