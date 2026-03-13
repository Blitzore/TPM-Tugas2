import 'dart:math';
import 'package:decimal/decimal.dart';
class MathLogic {
  

  // --- Logika Ganjil Genap & Prima ---
  static String checkParity(String input) {
    if (input.isEmpty) return "-";
    int lastDigit = int.parse(input[input.length - 1]);
    return lastDigit % 2 == 0 ? "Genap" : "Ganjil";
  }

  // --- Mesin Kriptografi: Miller-Rabin Primality Test ---
  static String checkPrime(String input) {
    BigInt? number = BigInt.tryParse(input);
    if (number == null || number <= BigInt.one) return "Bukan Prima";
    if (number == BigInt.two || number == BigInt.from(3)) return "Prima";
    if (number.isEven) return "Bukan Prima"; // Filter angka genap raksasa dalam O(1)

    // Tidak ada lagi batasan digit. Mesin ini sanggup menelan ratusan digit.
    // Kita gunakan Miller-Rabin dengan k=10 (cukup akurat untuk tugas kampus)
    bool isPrime = _millerRabinTest(number, 10);
    return isPrime ? "Prima" : "Bukan Prima";
  }

  // Algoritma tingkat lanjut untuk mengatasi angka sandi raksasa
  static bool _millerRabinTest(BigInt n, int k) {
    BigInt d = n - BigInt.one;
    int s = 0;
    
    while (d.isEven) {
      d = d >> 1;
      s++;
    }

    for (int i = 0; i < k; i++) {
      // Menggunakan basis kecil (2, 3, 4...) untuk pengujian. 
      // Cukup kuat untuk menggagalkan bilangan komposit (bukan prima).
      BigInt a = BigInt.from(2 + i); 
      if (a >= n - BigInt.one) break;

      // Operasi perpangkatan modular (kunci utama kriptografi yang dieksekusi sangat cepat)
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
    return true; // Probabilitas prima 99.999%
  }

  // --- Logika Tambahan untuk Frekuensi Angka ---
  static Map<String, int> getDigitFrequency(String input) {
    Map<String, int> freq = {};
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (RegExp(r'[0-9]').hasMatch(char)) {
        freq[char] = (freq[char] ?? 0) + 1;
      }
    }
    // Urutkan key dari 0-9
    var sortedKeys = freq.keys.toList()..sort();
    Map<String, int> sortedFreq = {};
    for (var k in sortedKeys) {
      sortedFreq[k] = freq[k]!;
    }
    return sortedFreq;
  }

  // --- Logika Hitung Jumlah Angka ---
  static int countNumbersInString(String input) {
    return input.replaceAll(RegExp(r'\D'), '').length;
  }

  // --- Logika Penjumlahan & Pengurangan (PRESISI ABSOLUT) ---
  static String add(String a, String b) {
    try {
      final d1 = Decimal.parse(a);
      final d2 = Decimal.parse(b);
      return (d1 + d2).toString();
    } catch (e) {
      return "Error";
    }
  }

  static String subtract(String a, String b) {
    try {
      final d1 = Decimal.parse(a);
      final d2 = Decimal.parse(b);
      return (d1 - d2).toString();
    } catch (e) {
      return "Error";
    }
  }
  // --- Logika Piramida (Asumsi Piramida Persegi) ---
  static double hitungVolumePiramid(double sisiAlas, double tinggi) {
    return (1 / 3) * pow(sisiAlas, 2) * tinggi;
  }

  static double hitungLuasPermukaanPiramid(double sisiAlas, double tinggi) {
    double luasAlas = pow(sisiAlas, 2).toDouble();
    // Mencari tinggi segitiga selimut menggunakan phytagoras
    double tinggiSegitiga = sqrt(pow((sisiAlas / 2), 2) + pow(tinggi, 2));
    double luasSelimut = 4 * (0.5 * sisiAlas * tinggiSegitiga);
    return luasAlas + luasSelimut;
  }

  static String formatCleanDouble(double value) {
    // 1. Bulatkan ke 10 desimal untuk memotong 'sampah' floating-point di ujung
    String str = value.toStringAsFixed(10); 
    
    // 2. Jika ada titik desimal, bersihkan angka 0 yang tidak berguna di belakang
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0*$'), ''); // Hapus trailing zero
      str = str.replaceAll(RegExp(r'\.$'), ''); // Hapus titik jika sendirian (misal "145.")
    }
    
    return str;
  }
}