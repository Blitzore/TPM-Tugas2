import 'dart:math';
import 'package:decimal/decimal.dart';

class MathLogic {
  // Mengecek apakah angka terakhir ganjil atau genap
  static String checkParity(String input) {
    if (input.isEmpty) return "0";
    int lastDigit = int.parse(input[input.length - 1]);
    return lastDigit % 2 == 0 ? "Genap" : "Ganjil";
  }

  // Uji bilangan prima menggunakan algoritma Miller-Rabin
  static String checkPrime(String input) {
    BigInt? number = BigInt.tryParse(input);
    if (number == null || number <= BigInt.one) return "Bukan Prima";
    if (number == BigInt.two || number == BigInt.from(3)) return "Prima";
    if (number.isEven) return "Bukan Prima";

    return _millerRabinTest(number, 10) ? "Prima" : "Bukan Prima";
  }

  static bool _millerRabinTest(BigInt n, int k) {
    BigInt d = n - BigInt.one;
    int s = 0;
    
    while (d.isEven) {
      d = d >> 1;
      s++;
    }

    for (int i = 0; i < k; i++) {
      BigInt a = BigInt.from(2 + i); 
      if (a >= n - BigInt.one) break;

      BigInt x = a.modPow(d, n);
      if (x == BigInt.one || x == n - BigInt.one) continue;

      bool composite = true;
      for (int r = 1; r < s; r++) {
        x = x.modPow(BigInt.two, n);
        if (x == n - BigInt.one) {
          composite = false;
          break;
        }
      }
      if (composite) return false;
    }
    return true;
  }

  // Menghitung kemunculan setiap digit angka dalam string
  static Map<String, int> getDigitFrequency(String input) {
    Map<String, int> freq = {};
    for (var char in input.split('')) {
      if (RegExp(r'[0-9]').hasMatch(char)) {
        freq[char] = (freq[char] ?? 0) + 1;
      }
    }
    
    var sortedKeys = freq.keys.toList()..sort();
    return {for (var k in sortedKeys) k: freq[k]!};
  }

  // Menghitung total digit angka yang ada di dalam string
  static int countNumbersInString(String input) {
    return input.replaceAll(RegExp(r'\D'), '').length;
  }

  // Operasi aritmatika dengan presisi tinggi (Decimal)
  static String add(String a, String b) {
    try {
      return (Decimal.parse(a) + Decimal.parse(b)).toString();
    } catch (e) {
      return "Error";
    }
  }

  static String subtract(String a, String b) {
    try {
      return (Decimal.parse(a) - Decimal.parse(b)).toString();
    } catch (e) {
      return "Error";
    }
  }

  // Perhitungan Geometri: Piramida
  static double hitungVolumePiramid(double sisiAlas, double tinggi) {
    return (1 / 3) * pow(sisiAlas, 2) * tinggi;
  }

  static double hitungLuasPermukaanPiramid(double sisiAlas, double tinggi) {
    double luasAlas = pow(sisiAlas, 2).toDouble();
    double tinggiSegitiga = sqrt(pow((sisiAlas / 2), 2) + pow(tinggi, 2));
    double luasSelimut = 4 * (0.5 * sisiAlas * tinggiSegitiga);
    return luasAlas + luasSelimut;
  }

  // Menghapus angka nol yang tidak perlu di belakang koma
  static String formatCleanDouble(double value) {
    String str = value.toStringAsFixed(10); 
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return str;
  }
}