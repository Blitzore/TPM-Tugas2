import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // WAJIB ADA
import 'package:tugas1/utils/math_logic.dart';

class CheckEvenOddPage extends StatefulWidget {
  const CheckEvenOddPage({super.key});

  @override
  _CheckEvenOddPageState createState() => _CheckEvenOddPageState();
}

class _CheckEvenOddPageState extends State<CheckEvenOddPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _checkNumber() {
    final int? number = int.tryParse(_controller.text);
    if (number == null) {
      setState(() {
        _result = "Masukkan angka yang valid";
      });
    } else {
      String parity = MathLogic.checkParity(number);
      String prime = MathLogic.isPrime(number) ? "Bilangan Prima" : "Bukan Bilangan Prima";
      
      setState(() {
        _result = "Angka $number adalah Bilangan $parity\ndan $prime";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganjil Genap & Prima")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number, // Murni number, tanpa opsi desimal
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))], // Regex murni 0-9 tanpa titik
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Masukkan angka bulat",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(onPressed: _checkNumber, child: const Text("Cek")),
              const SizedBox(height: 20),
              Text(
                _result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}