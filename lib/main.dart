import 'package:flutter/material.dart';
import 'package:tugas1/pages/loginpage.dart';
import 'package:tugas1/pages/homepage.dart';
import 'package:tugas1/pages/ganjilgenap_page.dart';
import 'package:tugas1/pages/penjumlahan_page.dart';
import 'package:tugas1/pages/pengurangan_page.dart';
import 'package:tugas1/pages/jumlah_angka.dart';
import 'package:tugas1/pages/stopwatch_page.dart';
import 'package:tugas1/pages/piramid_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Kelompok',
      debugShowCheckedModeBanner: false,
      
     
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), 
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Warna abu-abu sangat terang untuk background
        
        // Standarisasi AppBar: Bersih, tanpa bayangan (flat), teks tebal
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF8FAFC),
          scrolledUnderElevation: 0, // Mencegah perubahan warna saat di-scroll di M3
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0F172A)),
          titleTextStyle: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        
        // Standarisasi Tombol: Melengkung halus, padding luas, tanpa bayangan default
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        
        // Standarisasi Input TextField: Tampilan modern bergaya "filled"
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIconColor: Colors.grey.shade500,
        ),
        
        // Standarisasi Card
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
        ),
      ),

      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Homepages(),
        // Catatan: Pastikan page di bawah ini sudah pakai 'const' di file aslinya 
        // jika constructor mereka mendukungnya. Jika error, hapus 'const' di sini.
        '/penjumlahan': (context) => const PenjumlahanPage(), 
        '/pengurangan': (context) => const PenguranganPage(),
        '/ganjil-genap': (context) => CheckEvenOddPage(),
        '/jumlah-angka': (context) => NumberInputPage(),
        '/stopwatch': (context) => StopwatchPage(),
        '/piramid': (context) => const PiramidPage(),
      },
    );
  }
}