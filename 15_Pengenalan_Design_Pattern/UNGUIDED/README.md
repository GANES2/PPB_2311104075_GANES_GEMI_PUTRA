# Unguided Modul 14 -> Refactor Design Pattern (MVVM)

## Design Pattern yang dipakai
**MVVM (Model–View–ViewModel)** menggunakan state management **GetX**.

### Pemisahan Tanggung Jawab
- **Model**: `lib/models/mahasiswa.dart` (struktur data Mahasiswa)
- **ViewModel**: `lib/viewmodels/mahasiswa_viewmodel.dart` (state + business logic: tambah/hapus, validasi, hitung rata-rata IPK)
- **View**: `lib/views/mahasiswa_page.dart` (UI + input user, memanggil ViewModel)

## Fitur Aplikasi
- Tambah mahasiswa (Nama, NIM, IPK)
- Validasi input (kreatifitas nilai tambah)
- Hapus mahasiswa dengan konfirmasi
- Ringkasan total mahasiswa & rata-rata IPK

## Cara Menjalankan (paling gampang)
> Folder ZIP ini fokus ke source code `lib/` + `pubspec.yaml`.
> Jika kamu belum punya project Flutter untuk ditempel:

1. Ekstrak ZIP ini.
2. Buka terminal di folder hasil extract.
3. Buat project Flutter (sekali saja):
   ```bash
   flutter create .
   ```
   (Jika kamu sudah punya project, langkah ini tidak perlu)
4. Pastikan `pubspec.yaml` memakai yang ada di ZIP ini (atau salin bagian dependency `get:`).
5. Jalankan:
   ```bash
   flutter pub get
   flutter run
   ```

## Screenshot Output (Wajib)
Taruh screenshot kamu ke folder `screenshots/`:
- `01_home.png` (halaman utama + ringkasan)
- `02_dialog_tambah.png` (dialog tambah)
- `03_data_terisi.png` (setelah tambah data) / `03_hapus.png` (dialog hapus)

## Deskripsi Program (buat laporan)
Aplikasi Data Mahasiswa berbasis Flutter menerapkan MVVM, di mana View hanya mengelola tampilan dan input,
sedangkan seluruh business logic dan state (validasi, tambah/hapus data, dan perhitungan rata-rata IPK)
dikelola oleh ViewModel. Pemisahan ini membuat kode lebih rapi, mudah diuji, dan mudah dikembangkan.
