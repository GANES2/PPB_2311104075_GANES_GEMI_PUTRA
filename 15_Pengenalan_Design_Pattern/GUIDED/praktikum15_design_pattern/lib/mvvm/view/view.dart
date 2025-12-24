import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/viewmodel.dart';

class ViewMVVM extends StatelessWidget {
  ViewMVVM({super.key});

  final MahasiswaViewModel viewModel = Get.put(MahasiswaViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa - MVVM'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.purple[50],
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel.jumlahMahasiswa),
                  Text(viewModel.rataRataIPK),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: viewModel.listMahasiswa.length,
                itemBuilder: (context, index) {
                  final mhs = viewModel.listMahasiswa[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple[100],
                      child: Text(mhs.nama[0]),
                    ),
                    title: Text(mhs.nama),
                    subtitle: Text('NIM: ${mhs.nim} | IPK: ${mhs.ipk}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => viewModel.hapusMahasiswa(index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          viewModel.tambahMahasiswa('Aflah', '123456', 3.5);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
