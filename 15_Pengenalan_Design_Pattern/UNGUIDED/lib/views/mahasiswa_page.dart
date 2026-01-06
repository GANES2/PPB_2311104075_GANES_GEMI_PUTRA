import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/mahasiswa_viewmodel.dart';

/// View: hanya tampilan + input user. Logic ada di ViewModel (MVVM).
class MahasiswaPage extends StatelessWidget {
  MahasiswaPage({super.key});

  final MahasiswaViewModel vm = Get.put(MahasiswaViewModel());

  void _showTambahDialog(BuildContext context) {
    final namaC = TextEditingController();
    final nimC = TextEditingController();
    final ipkC = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Tambah Mahasiswa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaC,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: nimC,
              decoration: const InputDecoration(labelText: "NIM"),
            ),
            TextField(
              controller: ipkC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "IPK (0 - 4)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              final err = vm.validateInput(namaC.text, nimC.text, ipkC.text);
              if (err != null) {
                Get.snackbar("Validasi Gagal", err, snackPosition: SnackPosition.BOTTOM);
                return;
              }
              final ipk = double.parse(ipkC.text.replaceAll(',', '.'));
              vm.tambahMahasiswa(namaC.text, nimC.text, ipk);
              Get.back();
              Get.snackbar("Sukses", "Mahasiswa berhasil ditambahkan",
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Mahasiswa (MVVM)"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTambahDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Ringkasan (kreatifitas): card ringkasan.
          Obx(() {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ${vm.totalMahasiswa}"),
                  Text("Rata-rata IPK: ${vm.rataRataIpk.toStringAsFixed(2)}"),
                ],
              ),
            );
          }),

          Expanded(
            child: Obx(() {
              if (vm.daftarMahasiswa.isEmpty) {
                return const Center(child: Text("Belum ada data mahasiswa."));
              }

              return ListView.builder(
                itemCount: vm.daftarMahasiswa.length,
                itemBuilder: (context, index) {
                  final m = vm.daftarMahasiswa[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(m.nama.isNotEmpty ? m.nama[0].toUpperCase() : "?"),
                      ),
                      title: Text(m.nama),
                      subtitle: Text("NIM: ${m.nim} | IPK: ${m.ipk}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Hapus Data",
                            middleText: "Yakin hapus ${m.nama}?",
                            textCancel: "Batal",
                            textConfirm: "Hapus",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              vm.hapusMahasiswa(index);
                              Get.back();
                              Get.snackbar("Terhapus", "Data berhasil dihapus",
                                  snackPosition: SnackPosition.BOTTOM);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
