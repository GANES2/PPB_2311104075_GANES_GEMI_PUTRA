import 'package:get/get.dart';
import '../models/mahasiswa.dart';

/// ViewModel: tempat business logic + state aplikasi (MVVM).
class MahasiswaViewModel extends GetxController {
  final RxList<Mahasiswa> daftarMahasiswa = <Mahasiswa>[].obs;

  /// (Kreatifitas) Validasi sederhana + pesan error.
  String? validateInput(String nama, String nim, String ipkText) {
    if (nama.trim().isEmpty) return "Nama tidak boleh kosong.";
    if (nim.trim().isEmpty) return "NIM tidak boleh kosong.";
    final ipk = double.tryParse(ipkText.replaceAll(',', '.'));
    if (ipk == null) return "IPK harus angka.";
    if (ipk < 0 || ipk > 4) return "IPK harus 0.0 - 4.0.";
    return null;
  }

  void tambahMahasiswa(String nama, String nim, double ipk) {
    daftarMahasiswa.add(Mahasiswa(nama: nama.trim(), nim: nim.trim(), ipk: ipk));
  }

  void hapusMahasiswa(int index) {
    if (index >= 0 && index < daftarMahasiswa.length) {
      daftarMahasiswa.removeAt(index);
    }
  }

  int get totalMahasiswa => daftarMahasiswa.length;

  double get rataRataIpk {
    if (daftarMahasiswa.isEmpty) return 0;
    final total = daftarMahasiswa.fold<double>(0, (sum, mhs) => sum + mhs.ipk);
    return total / daftarMahasiswa.length;
  }
}
