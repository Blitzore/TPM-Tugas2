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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, 
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),

      
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Homepages(),
        '/penjumlahan': (context) => PenjumlahanPage(), 
        '/pengurangan': (context) => PenguranganPage(),
        '/ganjil-genap': (context) => CheckEvenOddPage(),
        '/jumlah-angka': (context) => NumberInputPage(),
        '/stopwatch': (context) => StopwatchPage(),
        '/piramid': (context) => PiramidPage(),
      },
    );
  }
}