String nilai(int angka) {
  if (angka > 70) {
    return "Nilai A";
  } else if (angka > 40 && angka <= 70) {
    return "Nilai B";
  } else if (angka > 0 && angka <= 40) {
    return "Nilai C";
  } else {
    return "";
  }
}

void main() {
  int input1 = 80;
  int input2 = 50;
  
  print('$input1 merupakan ${nilai(input1)}');
  print('$input2 merupakan ${nilai(input2)}');
}