import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas1/utils/math_logic.dart';

class PenguranganPage extends StatefulWidget {
  const PenguranganPage({super.key});

  @override
  _PenguranganPageState createState() => _PenguranganPageState();
}

class _PenguranganPageState extends State<PenguranganPage> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();
  String _hasil = "0";

  void _hitung() {
    if (_angka1Controller.text.trim().isEmpty || _angka2Controller.text.trim().isEmpty) {
      setState(() {
        _hasil = "Silahkan isi semua bagian";
      });
      return;
    }

    // Ubah koma menjadi titik untuk standarisasi parsing
    String input1 = _angka1Controller.text.replaceAll(',', '.');
    String input2 = _angka2Controller.text.replaceAll(',', '.');

    // Langsung lemparkan teks mentahnya ke MathLogic!
    String result = MathLogic.subtract(input1, input2);

    setState(() {
      if (result == "Error") {
        _hasil = "Input tidak valid";
      } else {
        _hasil = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengurangan")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _angka1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: "Angka Pertama", 
                filled: true, 
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _angka2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: "Angka Kedua", 
                filled: true, 
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitung, 
              child: const Text("Hitung Pengurangan")
            ),
            const SizedBox(height: 20),
            Text(
              "Hasil: $_hasil", 
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)
            ),
          ],
        ),
      ),
    );
  }
}