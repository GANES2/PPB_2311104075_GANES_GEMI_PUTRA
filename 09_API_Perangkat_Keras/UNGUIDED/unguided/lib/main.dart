import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const UnguidedImagePickerApp());
}

class UnguidedImagePickerApp extends StatelessWidget {
  const UnguidedImagePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 09 - Image Picker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();

  File? _imageFile;
  String _statusText = "Belum ada gambar dipilih";

  Future<void> _pickFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) {
        _snack("Batal memilih gambar dari galeri.");
        return;
      }
      setState(() {
        _imageFile = File(picked.path);
        _statusText = "Sumber: Gallery";
      });
      _snack("Berhasil mengambil gambar dari galeri ✅");
    } catch (e) {
      _snack("Gagal akses galeri: $e");
    }
  }

  Future<void> _pickFromCamera() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (picked == null) {
        _snack("Batal mengambil gambar dari kamera.");
        return;
      }
      setState(() {
        _imageFile = File(picked.path);
        _statusText = "Sumber: Camera";
      });
      _snack("Berhasil mengambil gambar dari kamera ✅");
    } catch (e) {
      _snack("Gagal akses kamera: $e");
    }
  }

  void _deleteImage() {
    if (_imageFile == null) {
      _snack("Tidak ada gambar untuk dihapus.");
      return;
    }
    setState(() {
      _imageFile = null;
      _statusText = "Gambar dihapus";
    });
    _snack("Gambar berhasil dihapus 🗑️");
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Unguided - Pemilihan Gambar"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card (kreatifitas)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cs.primaryContainer, cs.secondaryContainer],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, color: cs.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Pilih gambar dari Gallery atau Camera, lalu tampilkan di container. "
                      "Kamu juga bisa hapus gambar kapan saja.",
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Container gambar
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: cs.outlineVariant,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.image_outlined),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _statusText,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (_imageFile != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              "READY",
                              style: TextStyle(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          width: double.infinity,
                          color: cs.surfaceContainerHighest,
                          child: _imageFile == null
                              ? _EmptyState(
                                  onGallery: _pickFromGallery,
                                  onCamera: _pickFromCamera,
                                )
                              : Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Tombol sesuai ketentuan
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _pickFromGallery,
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text("Gallery"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _pickFromCamera,
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: const Text("Camera"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _deleteImage,
                icon: const Icon(Icons.delete_outline),
                label: const Text("Hapus Gambar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  const _EmptyState({
    required this.onGallery,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_upload_outlined, size: 64, color: cs.primary),
            const SizedBox(height: 10),
            const Text(
              "Belum ada gambar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              "Klik tombol Gallery atau Camera untuk menambahkan gambar.",
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                FilledButton.tonalIcon(
                  onPressed: onGallery,
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text("Gallery"),
                ),
                FilledButton.tonalIcon(
                  onPressed: onCamera,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text("Camera"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
