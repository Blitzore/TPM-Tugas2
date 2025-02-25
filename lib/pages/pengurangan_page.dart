import 'package:flutter/material.dart';
import 'package:tugas1/pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PenguranganPage(),
    );
  }
}

class PenguranganPage extends StatefulWidget {
  const PenguranganPage({Key? key}) : super(key: key);

  @override
  _PenguranganPageState createState() => _PenguranganPageState();
}

class _PenguranganPageState extends State<PenguranganPage> {
  TextEditingController angka1Controller = TextEditingController();
  TextEditingController angka2Controller = TextEditingController();
  int hasil = 0;
  String errorMessage = "";

  void hitungPengurangan() {
    setState(() {
      if (angka1Controller.text.length > 15 || angka2Controller.text.length > 15) {
        errorMessage = "Maksimal 15 karakter untuk setiap input";
        hasil = 0;
      } else if (!RegExp(r'^\d+$').hasMatch(angka1Controller.text) || !RegExp(r'^\d+$').hasMatch(angka2Controller.text)) {
        errorMessage = "Masukkan hanya angka";
        hasil = 0;
      } else {
        int angka1 = int.tryParse(angka1Controller.text) ?? 0;
        int angka2 = int.tryParse(angka2Controller.text) ?? 0;
        hasil = angka1 - angka2;
        errorMessage = "";
      }
    });
  }

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepages()));
              },
            ),
            SizedBox(width: 10),
            Text("Pengurangan",
            style: TextStyle(fontSize: 24, color: Colors.white)),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 1, 45, 82),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: angka1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Angka Pertama",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: angka2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Angka Kedua",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10.0),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: hitungPengurangan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 45, 82),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                "HITUNG",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Hasil Pengurangan:",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "$hasil",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 45, 82),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}