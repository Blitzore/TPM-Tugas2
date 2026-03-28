import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas1/utils/math_logic.dart';

class CheckEvenOddPage extends StatefulWidget {
  const CheckEvenOddPage({super.key});

  @override
  State<CheckEvenOddPage> createState() => _CheckEvenOddPageState();
}

class _CheckEvenOddPageState extends State<CheckEvenOddPage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _hasilParity = "-";
  String _hasilPrima = "-";
  String _angkaDicek = "-";

void _checkNumber() {
    FocusScope.of(context).unfocus();
    
    if (_formKey.currentState!.validate()) {
      setState(() {
        _angkaDicek = _controller.text;
        _hasilParity = MathLogic.checkParity(_angkaDicek);
        _hasilPrima = MathLogic.checkPrime(_angkaDicek);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganjil Genap & Prima")),
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
                          Icon(Icons.rule, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          const Text(
                            "Pengecekan Angka", 
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                      
                      TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _checkNumber(),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*'))],
                        decoration: const InputDecoration(
                          labelText: "Masukkan Angka Bulat",
                          prefixIcon: Icon(Icons.numbers),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty 
                            ? "Wajib diisi" 
                            : null,
                      ),
                      const SizedBox(height: 24),
                      
                      ElevatedButton.icon(
                        onPressed: _checkNumber,
                        icon: const Icon(Icons.search),
                        label: const Text("CEK ANGKA"),
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Hasil Analisis Angka $_angkaDicek",
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildResultBox("Status Paritas", _hasilParity)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildResultBox("Status Prima", _hasilPrima)),
                      ],
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

  Widget _buildResultBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            title, 
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value, 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Theme.of(context).colorScheme.primary
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}