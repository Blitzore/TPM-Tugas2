import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas1/utils/math_logic.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  _PiramidPageState createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _sisiController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  String _hasilVolume = "0";
  String _hasilLuas = "0";

  void _hitung() {
    if (_sisiController.text.trim().isEmpty || _tinggiController.text.trim().isEmpty) {
      setState(() {
        _hasilVolume = "Silahkan isi semua bagian";
        _hasilLuas = "Silahkan isi semua bagian";
      });
      return;
    }

    String inputSisi = _sisiController.text.replaceAll(',', '.');
    String inputTinggi = _tinggiController.text.replaceAll(',', '.');

    double? sisi = double.tryParse(inputSisi);
    double? tinggi = double.tryParse(inputTinggi);

    if (sisi != null && tinggi != null) {
      setState(() {
        _hasilVolume = MathLogic.formatCleanDouble(MathLogic.hitungVolumePiramid(sisi, tinggi));
        _hasilLuas = MathLogic.formatCleanDouble(MathLogic.hitungLuasPermukaanPiramid(sisi, tinggi));
      });
    } else {
      setState(() {
        _hasilVolume = "Invalid";
        _hasilLuas = "Invalid";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Luas & Volume Piramida")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _sisiController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: "Panjang Sisi Alas", 
                filled: true, 
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tinggiController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: "Tinggi Piramida", 
                filled: true, 
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitung, 
              child: const Text("Kalkulasi")
            ),
            const SizedBox(height: 20),
            Text(
              "Volume: $_hasilVolume", 
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)
            ),
            const SizedBox(height: 5),
            Text(
              "Luas Permukaan: $_hasilLuas", 
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)
            ),
          ],
        ),
      ),
    );
  }
}