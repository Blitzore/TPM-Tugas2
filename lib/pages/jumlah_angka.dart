import 'package:flutter/material.dart';
import 'package:tugas1/utils/math_logic.dart';

class NumberInputPage extends StatefulWidget {
  const NumberInputPage({super.key});

  @override
  _NumberInputPageState createState() => _NumberInputPageState();
}

class _NumberInputPageState extends State<NumberInputPage> {
  final TextEditingController _controller = TextEditingController();
  int _numberCount = 0;

  void _countNumbers(String input) {
    setState(() {
      _numberCount = MathLogic.countNumbersInString(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          "Hitung Jumlah Angka",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Masukkan teks dengan angka",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _countNumbers,
            ),
            SizedBox(height: 20),
            Text(
              "Jumlah angka: $_numberCount",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
