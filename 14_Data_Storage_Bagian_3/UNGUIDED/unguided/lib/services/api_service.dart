import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => PostModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load posts (${response.statusCode})');
  }

  Future<PostModel> createPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      // JSONPlaceholder biasanya balikin id baru (101)
      return PostModel.fromJson(data);
    }
    throw Exception('Failed to create post (${response.statusCode})');
  }

  Future<PostModel> updatePost(int id, PostModel post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return PostModel.fromJson(data);
    }
    throw Exception('Failed to update post (${response.statusCode})');
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
    if (response.statusCode == 200) return;
    throw Exception('Failed to delete post (${response.statusCode})');
  }
}
