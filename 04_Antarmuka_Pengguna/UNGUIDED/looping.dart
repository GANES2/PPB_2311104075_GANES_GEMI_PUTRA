void piramidaBintang(int tinggi) {
  for (int i = 1; i <= tinggi; i++) {
    // Membuat spasi untuk perataan tengah
    String spasi = ' ' * (tinggi - i);
    // Membuat bintang dengan pola bilangan ganjil
    String bintang = '*' * (2 * i - 1);
    print(spasi + bintang);
  }
}

void main() {
  // Input dari user (dalam contoh ini tinggi = 5)
  int tinggiPiramida = 5;
  piramidaBintang(tinggiPiramida);
}