import 'package:flutter/material.dart';
import 'package:tugas1/utils/date_logic.dart';

class HijriahPage extends StatefulWidget {
  const HijriahPage({super.key});

  @override
  State<HijriahPage> createState() => _HijriahPageState();
}

class _HijriahPageState extends State<HijriahPage> {
  DateTime? _selectedDate;
  int _adjustment = 0; // Tambahan offset hari untuk beda MU/NU/Pemerintah
  String _hasilHijriah = "-";

  void _updateHasil() {
    if (_selectedDate != null) {
      setState(() {
        _hasilHijriah = DateLogic.getHijriahDate(_selectedDate!, adjustment: _adjustment);
      });
    }
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    
    if (picked != null) {
      _selectedDate = picked;
      _updateHasil();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konversi Kalender Hijriah")),
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
                        Icon(Icons.mosque, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 10),
                        const Text(
                          "Pilih Tanggal Masehi", 
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.date_range),
                      label: Text(_selectedDate != null 
                        ? "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}"
                        : "Tekan untuk Pilih Tanggal"),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: _adjustment,
                      decoration: const InputDecoration(
                        labelText: "Penyesuaian Tanggal (Pemerintah/NU/MU)",
                        prefixIcon: Icon(Icons.tune),
                      ),
                      items: const [
                        DropdownMenuItem(value: -2, child: Text("-2 Hari")),
                        DropdownMenuItem(value: -1, child: Text("-1 Hari")),
                        DropdownMenuItem(value: 0, child: Text("Standar (0 Hari)")),
                        DropdownMenuItem(value: 1, child: Text("+1 Hari")),
                        DropdownMenuItem(value: 2, child: Text("+2 Hari")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _adjustment = value!;
                          _updateHasil();
                        });
                      },
                    ),
                  ],
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
                      "Hasil Hijriah",
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      _hasilHijriah, 
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
