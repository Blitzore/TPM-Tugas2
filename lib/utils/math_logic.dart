import 'dart:math';
import 'package:decimal/decimal.dart';
class MathLogic {
  // --- Logika Ganjil Genap & Prima ---
  static bool isPrime(int number) {
    if (number <= 1) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    for (int i = 3; i <= number ~/ 2; i += 2) {
      if (number % i == 0) return false;
    }
    return true;
  }

  static String checkParity(int number) {
    return number % 2 == 0 ? "Genap" : "Ganjil";
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