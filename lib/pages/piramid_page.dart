import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tugas1/pages/homepage.dart';

class PiramidPage extends StatefulWidget {
  @override
  _PiramidPageState createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _sisiController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  String _result = "";

  void _hitungPiramid() {
    final double? sisi = double.tryParse(_sisiController.text);
    final double? tinggi = double.tryParse(_tinggiController.text);

    if (sisi == null || tinggi == null) {
      setState(() {
        _result = "Masukkan angka yang valid";
      });
      return;
    }

    double volume = (1 / 3) * (sisi * sisi) * tinggi;
    double tinggiSegitiga = sqrt(pow(sisi / 2, 2) + pow(tinggi, 2));
    double luasPermukaan = (sisi * sisi) + (4 * (0.5 * sisi * tinggiSegitiga));

    setState(() {
      _result =
          "Volume: ${volume.toStringAsFixed(2)}\nLuas Permukaan: ${luasPermukaan.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Luas & Volume Piramid",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepages()),
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _sisiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Panjang Sisi Alas",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _tinggiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi Piramid",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitungPiramid,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Hitung", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
