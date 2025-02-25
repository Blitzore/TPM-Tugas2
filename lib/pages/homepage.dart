import 'package:flutter/material.dart';
import 'package:tugas1/pages/loginpage.dart';
import 'package:tugas1/pages/testAngka.dart';
import 'package:tugas1/pages/ganjilGenap.dart';
import 'package:tugas1/pages/penjumlahan_page.dart';
import 'package:tugas1/pages/pengurangan_page.dart';

class Homepages extends StatelessWidget {
  const Homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        elevation: 5,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blueGrey, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      for (var name in [
                        "Ajeng Anugrah (123220060)",
                        "Agreswara Putri (123220182)",
                        "Arya Bhagaskara (123220188)",
                        "Novan Joko Trihananto (123220202)",
                      ])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _buildMenuButton(context, Icons.calculate, "PENJUMLAHAN", Colors.orange, () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PenjumlahanPage()));
                }),
                _buildMenuButton(context, Icons.calculate, "PENGURANGAN", const Color.fromARGB(255, 1, 45, 82), () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PenguranganPage()));
                }),
                _buildMenuButton(context, Icons.numbers, "PENENTUAN BILANGAN GANJIL GENAP", Colors.teal, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CheckEvenOddPage()),
                  );
                }),
                _buildMenuButton(context, Icons.search, "DETEKSI JUMLAH ANGKA", Colors.deepPurple, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NumberInputPage()),
                  );
                }),
                _buildMenuButton(context, Icons.logout, "Logout", Colors.red, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String text, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
