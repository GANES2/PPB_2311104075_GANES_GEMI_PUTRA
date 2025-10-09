import 'dart:io';

// Fungsi untuk mengecek bilangan prima
bool isPrime(int n) {
  // Bilangan kurang dari 2 bukan prima
  if (n < 2) {
    return false;
  }
  
  // Cek pembagi dari 2 hingga akar kuadrat n (dibulatkan)
  for (int i = 2; i <= n / 2; i++) {
    if (n % i == 0) {
      return false; // Ditemukan pembagi, bukan prima
    }
  }
  return true; // Tidak ada pembagi, bilangan prima
}

void main() {
  // Meminta input dari user
  stdout.write('Masukkan sebuah bilangan bulat: ');
  String? input = stdin.readLineSync();
  
  // Validasi input
  if (input != null && input.isNotEmpty) {
    int? number = int.tryParse(input);
    
    if (number != null) {

      if (isPrime(number)) {
        print('$number adalah bilangan prima');
      } else {
        print('$number adalah bukan bilangan prima');
      }
    } else {
      print('Input tidak valid! Harap masukkan bilangan bulat.');
    }
  } else {
    print('Input tidak boleh kosong!');
  }
}