import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class PostController extends GetxController {
  final ApiService _api = ApiService();

  final posts = <PostModel>[].obs;
  final isLoading = false.obs;

  // untuk input form (opsional, tapi bikin UI terasa “premium”)
  final title = ''.obs;
  final body = ''.obs;

  void setTitle(String v) => title.value = v;
  void setBody(String v) => body.value = v;

  Future<void> getPosts() async {
    await _run(() async {
      final data = await _api.fetchPosts();
      posts.assignAll(data);
      Get.snackbar(
        'Sukses',
        'Data berhasil diambil!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    });
  }

  Future<void> addPost() async {
    await _run(() async {
      final newPost = PostModel(
        title: title.value.isEmpty ? 'Flutter Post' : title.value,
        body: body.value.isEmpty ? 'Ini contoh POST.' : body.value,
        userId: 1,
      );

      final created = await _api.createPost(newPost);

      // JSONPlaceholder tidak benar-benar nyimpen, jadi kita simpan lokal juga
      posts.insert(0, created.copyWith(
        // kalau API balikin null id, bikin id lokal
        id: created.id ?? (posts.isNotEmpty ? (posts.first.id ?? 0) + 1 : 1),
      ));

      Get.snackbar(
        'Sukses',
        'Data berhasil ditambahkan!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    });
  }

  Future<void> updateFirst() async {
    if (posts.isEmpty) {
      Get.snackbar(
        'Info',
        'Ambil data dulu (GET) sebelum UPDATE',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    final targetId = posts.first.id ?? 1;

    await _run(() async {
      final updatedReq = PostModel(
        id: targetId,
        title: title.value.isEmpty ? 'Updated Title' : title.value,
        body: body.value.isEmpty ? 'Updated Body' : body.value,
        userId: 1,
      );

      final updated = await _api.updatePost(targetId, updatedReq);

      // update lokal
      posts[0] = posts[0].copyWith(
        title: updated.title,
        body: updated.body,
      );

      Get.snackbar(
        'Sukses',
        'Data berhasil diperbarui!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    });
  }

  Future<void> deleteFirst() async {
    if (posts.isEmpty) {
      Get.snackbar(
        'Info',
        'Tidak ada data untuk dihapus',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    final targetId = posts.first.id ?? 1;

    await _run(() async {
      await _api.deletePost(targetId);
      posts.removeAt(0);
      Get.snackbar(
        'Sukses',
        'Data berhasil dihapus!',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    });
  }

  Future<void> _run(Future<void> Function() operation) async {
    try {
      isLoading.value = true;
      await operation();
    } catch (e) {
      Get.snackbar(
        'Gagal',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
