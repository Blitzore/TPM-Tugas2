import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas1/utils/math_logic.dart';

class PenjumlahanPage extends StatefulWidget {
  const PenjumlahanPage({super.key});

  @override
  State<PenjumlahanPage> createState() => _PenjumlahanPageState();
}

class _PenjumlahanPageState extends State<PenjumlahanPage> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _hasil = "-";

  void _hitung() {
    FocusScope.of(context).unfocus(); 
    
    if (_formKey.currentState!.validate()) {
      String input1 = _angka1Controller.text.replaceAll(',', '.');
      String input2 = _angka2Controller.text.replaceAll(',', '.');

      String result = MathLogic.add(input1, input2);

      setState(() {
        if (result == "Error") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Input tidak valid."),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
          _hasil = "-";
        } else {
          _hasil = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Penjumlahan")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.add_circle_outline, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          const Text(
                            "Masukkan Angka", 
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                      TextFormField(
                        controller: _angka1Controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'))],
                        decoration: const InputDecoration(
                          labelText: "Angka Pertama",
                          prefixIcon: Icon(Icons.looks_one_outlined),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty ? "Wajib diisi" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _angka2Controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _hitung(),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'))],
                        decoration: const InputDecoration(
                          labelText: "Angka Kedua",
                          prefixIcon: Icon(Icons.looks_two_outlined),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty ? "Wajib diisi" : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _hitung,
                        icon: const Icon(Icons.calculate),
                        label: const Text("JUMLAHKAN"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      "Hasil Penjumlahan",
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      _hasil, 
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}