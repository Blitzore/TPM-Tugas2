import 'package:flutter/material.dart';

class Homepages extends StatelessWidget {
  const Homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 10),
              child: const Text(
                "Dashboard Utama",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1.2),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: Colors.blue, // Menambahkan warna background agar teks putih terlihat
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.blue, offset: Offset(0, 5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.group, color: Colors.white70, size: 20),
                      SizedBox(width: 10),
                      Text("Anggota Kelompok", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600)),
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
            const Text("Menu Aplikasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 15),
            
            // PERUBAHAN: Menggunakan Named Routes
            _buildListItem(context, Icons.add_circle_outline, "Penjumlahan", Colors.blue, '/penjumlahan'),
            _buildListItem(context, Icons.remove_circle_outline, "Pengurangan", Colors.blue, '/pengurangan'),
            _buildListItem(context, Icons.rule, "Ganjil Genap & Prima", Colors.blue, '/ganjil-genap'),
            _buildListItem(context, Icons.calculate_outlined, "Total Angka Input", Colors.blue, '/jumlah-angka'),
            _buildListItem(context, Icons.timer_outlined, "Stopwatch", Colors.blue, '/stopwatch'),
            _buildListItem(context, Icons.change_history, "Luas & Volume Piramid", Colors.blue, '/piramid'),
            
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // PERUBAHAN: Logout menggunakan route
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

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

  // PERUBAHAN: Parameter menerima String routeName
  Widget _buildListItem(BuildContext context, IconData icon, String title, Color color, String routeName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          // PERUBAHAN: Gunakan push, agar ada tombol back otomatis
          Navigator.pushNamed(context, routeName);
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
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800])),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}