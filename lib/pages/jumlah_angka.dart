import 'package:flutter/material.dart';
import 'package:tugas1/utils/math_logic.dart';

class NumberInputPage extends StatefulWidget {
  const NumberInputPage({super.key});

  @override
  State<NumberInputPage> createState() => _NumberInputPageState();
}

class _NumberInputPageState extends State<NumberInputPage> {
  final TextEditingController _controller = TextEditingController();
  int _numberCount = 0;
  Map<String, int> _digitFrequency = {};

  void _analyzeInput(String input) {
    setState(() {
      _numberCount = MathLogic.countNumbersInString(input);
      _digitFrequency = MathLogic.getDigitFrequency(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Total & Analisis Angka")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.analytics_outlined, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 10),
                        const Text("Input Teks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 30),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Ketik teks apa saja...",
                        prefixIcon: Icon(Icons.text_fields),
                        hintText: "Contoh: tugas 2 tpm 2026",
                      ),
                      onChanged: _analyzeInput,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // --- HEADER TOTAL ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text("Total Digit", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  Text(_numberCount.toString(), style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, height: 1.1)),
                ],
              ),
            ),
            
            // --- DETAIL FREKUENSI ---
            if (_digitFrequency.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text("Rincian Frekuensi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _digitFrequency.entries.map((entry) {
                  return Chip(
                    label: Text("${entry.key}  =  ${entry.value}x", style: const TextStyle(fontWeight: FontWeight.bold)),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  );
                }).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}