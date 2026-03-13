import 'package:flutter/material.dart';
import 'package:tugas1/pages/loginpage.dart';
import 'package:tugas1/pages/ganjilgenap.dart';
import 'package:tugas1/pages/penjumlahan_page.dart';
import 'package:tugas1/pages/pengurangan_page.dart';
import 'package:tugas1/pages/jumlah_angka.dart'; 
import 'package:tugas1/pages/stopwatch_page.dart';
import 'package:tugas1/pages/piramid_page.dart';

class Homepages extends StatelessWidget {
  const Homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), 
      // AppBar dihilangkan agar ruang layar lebih maksimal
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          physics: const BouncingScrollPhysics(), // Memberikan efek memantul saat mentok
          children: [
            // 1. Teks Judul Dashboard Utama
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 10),
              child: const Text(
                "Dashboard Utama",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey, // Warna Indigo gelap
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            // 2. Kotak Khusus Anggota Kelompok
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.group, color: Colors.white70, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Anggota Kelompok",
                        style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white30, height: 20, thickness: 1),
                  _buildMemberText("Gilang Restu Maulana", "123230060"),
                  _buildMemberText("Ahmad Habib Hamidi", "123230077"),
                  _buildMemberText("Raymond Agung Raditya", "123230129"),
                  _buildMemberText("Laksana Atmaja Putra", "123230235"),
                ],
              ),
            ),
            
            // 3. Label Daftar Menu
            const Text(
              "Menu Aplikasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            
            // 4. Daftar Kotak Menu (List Item)
            _buildListItem(context, Icons.add_circle_outline, "Penjumlahan", Colors.blue, PenjumlahanPage()),
            _buildListItem(context, Icons.remove_circle_outline, "Pengurangan", Colors.blue, PenguranganPage()),
            _buildListItem(context, Icons.rule, "Ganjil Genap & Prima", Colors.blue, CheckEvenOddPage()),
            _buildListItem(context, Icons.calculate_outlined, "Total Angka Input", Colors.blue, NumberInputPage()),
            _buildListItem(context, Icons.timer_outlined, "Stopwatch", Colors.blue, StopwatchPage()),
            _buildListItem(context, Icons.change_history, "Luas & Volume Piramid", Colors.blue, PiramidPage()),
            
            const SizedBox(height: 20),
            
            // 5. Kotak Tombol Logout di paling bawah ListView
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Widget tambahan untuk merapikan baris nama dan NIM
  Widget _buildMemberText(String name, String nim) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(nim, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  // Desain kotak menu
  Widget _buildListItem(BuildContext context, IconData icon, String title, Color color, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}