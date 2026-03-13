import 'package:flutter/material.dart';
import 'package:tugas1/pages/homepage.dart';

class CheckEvenOddPage extends StatefulWidget {
  @override
  _CheckEvenOddPageState createState() => _CheckEvenOddPageState();
}

class _CheckEvenOddPageState extends State<CheckEvenOddPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  bool _isPrime(int number) {
    if (number <= 1) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    for (int i = 3; i <= number ~/ 2; i += 2) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void _checkNumber() {
    final int? number = int.tryParse(_controller.text);
    if (number == null) {
      setState(() {
        _result = "Masukkan angka yang valid";
      });
    } else {
      String parity = number % 2 == 0 ? "Genap" : "Ganjil";
      String prime = _isPrime(number) ? "Bilangan Prima" : "Bukan Bilangan Prima";
      setState(() {
        _result = "Angka $number adalah Bilangan $parity\ndan $prime";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganjil Genap & Prima",
        style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepages()));
          },
        ),
      ),
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Masukkan angka",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _checkNumber,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text("Cek", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}