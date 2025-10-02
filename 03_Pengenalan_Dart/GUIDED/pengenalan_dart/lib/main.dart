void main() {
  // Menghitung jumlah dengan perulangan for
  int jumlahFor = 0;
  for (int i = 1; i <= 10; i++) {
    jumlahFor += i;
  }
  print("Jumlah bilangan 1 sampai 10 dengan for: $jumlahFor");

  // Menghitung jumlah dengan perulangan while
  int jumlahWhile = 0;
  int j = 1;
  while (j <= 10) {
    jumlahWhile += j;
    j++;
  }
  print("Jumlah bilangan 1 sampai 10 dengan while: $jumlahWhile");
}
