import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PostController c = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Storage API (GetX)'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              _HeaderCard(controller: c),
              const SizedBox(height: 20),
              Obx(() {
                if (c.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (c.posts.isEmpty) {
                  return const Center(
                    child: Text(
                      'Tekan tombol GET untuk mengambil data',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.posts.length,
                  itemBuilder: (context, index) {
                    final p = c.posts[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: Text(
                            '${p.id ?? '-'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          p.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          p.body,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.controller});

  final PostController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Input (opsional)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: controller.setTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: controller.setBody,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.isLoading.value ? null : controller.getPosts,
                  icon: controller.isLoading.value
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.download),
                  label: controller.isLoading.value
                      ? const SizedBox.shrink()
                      : const Text('GET'),
                ),
                ElevatedButton.icon(
                  onPressed: controller.isLoading.value ? null : controller.addPost,
                  icon: controller.isLoading.value
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.add),
                  label: controller.isLoading.value
                      ? const SizedBox.shrink()
                      : const Text('POST'),
                ),
                ElevatedButton.icon(
                  onPressed: controller.isLoading.value ? null : controller.updateFirst,
                  icon: controller.isLoading.value
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.edit),
                  label: controller.isLoading.value
                      ? const SizedBox.shrink()
                      : const Text('UPDATE'),
                ),
                ElevatedButton.icon(
                  onPressed: controller.isLoading.value ? null : controller.deleteFirst,
                  icon: controller.isLoading.value
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.delete),
                  label: controller.isLoading.value
                      ? const SizedBox.shrink()
                      : const Text('DELETE'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
