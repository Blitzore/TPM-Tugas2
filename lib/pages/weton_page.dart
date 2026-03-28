import 'package:flutter/material.dart';
import 'package:tugas1/utils/date_logic.dart';

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
  DateTime? _selectedDate;
  String _hasilHariWeton = "-";
  String _hasilTanggalJawa = "-";

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _hasilHariWeton = DateLogic.getHariWeton(picked);
        _hasilTanggalJawa = DateLogic.getTanggalJawa(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konversi Hari & Weton")),
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
                        Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 10),
                        const Text(
                          "Pilih Tanggal Masuk", 
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
                      "Hari & Pasaran",
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      _hasilHariWeton, 
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      "Tanggal Jawa / Pranata Mangsa",
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      _hasilTanggalJawa, 
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        letterSpacing: -0.5,
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
