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
      home: CheckEvenOddPage(),
    );
  }
}

class CheckEvenOddPage extends StatefulWidget {
  @override
  _CheckEvenOddPageState createState() => _CheckEvenOddPageState();
}

class _CheckEvenOddPageState extends State<CheckEvenOddPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _checkEvenOdd() {
    if (_controller.text.length > 15) {
      setState(() {
        _result = "Input melebihi batas (maksimal 15 karakter)";
      });
      return;
    }

    final int? number = int.tryParse(_controller.text);
    if (number == null) {
      setState(() {
        _result = "Masukkan angka yang valid";
      });
    } else {
      setState(() {
        _result = number % 2 == 0 ? "Bilangan Genap" : "Bilangan Ganjil";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Bilangan"),
        backgroundColor: Colors.teal[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepages()));
          },
        ),
      ),
      backgroundColor: Colors.teal[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Masukkan angka",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.numbers, color: Colors.teal[700]),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _checkEvenOdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  "Cek",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
