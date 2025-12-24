import 'package:get/get.dart';
import '../model/model.dart';

class MahasiswaController extends GetxController {
  RxList<Mahasiswa> listMahasiswa = <Mahasiswa>[].obs;

  // Add
  void tambahData(String nama, String nim, double ipk) {
    Mahasiswa newMahasiswa = Mahasiswa(nama: nama, nim: nim, ipk: ipk);
    listMahasiswa.add(newMahasiswa);
  }

  // Delete
  void hapusData(int index) {
    if (index >= 0 && index < listMahasiswa.length) {
      listMahasiswa.removeAt(index);
    }
  }

  // Average
  double hitungData() {
    if (listMahasiswa.isEmpty) return 0;

    double avg = 0;
    for (var mhs in listMahasiswa) {
      avg += mhs.ipk;
    }
    return avg / listMahasiswa.length;
  }
}
