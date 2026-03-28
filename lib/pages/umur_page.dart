import 'package:flutter/material.dart';
import 'package:tugas1/utils/date_logic.dart';

class UmurPage extends StatefulWidget {
  const UmurPage({super.key});

  @override
  State<UmurPage> createState() => _UmurPageState();
}

class _UmurPageState extends State<UmurPage> {
  DateTime? _selectedDateTime;
  Map<String, int> _hasilUmur = {};

  void _pickDateTime() async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate != null && mounted) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year, 
          pickedDate.month, 
          pickedDate.day, 
          pickedTime.hour, 
          pickedTime.minute
        );
        setState(() {
          _selectedDateTime = finalDateTime;
          _hasilUmur = DateLogic.getDetailUmur(finalDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Umur Detail")),
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
                        Icon(Icons.cake, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 10),
                        const Text(
                          "Masukkan Tanggal & Waktu Lahir", 
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    OutlinedButton.icon(
                      onPressed: _pickDateTime,
                      icon: const Icon(Icons.access_time),
                      label: Text(_selectedDateTime != null 
                        ? "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} ${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}"
                        : "Pilih Tanggal dan Waktu"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            if (_hasilUmur.isNotEmpty) ...[
              const Text("Detail Umur Anda:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Column(
                children: [
                  _buildVerticalStat("Tahun", _hasilUmur['tahun']!),
                  _buildVerticalStat("Bulan", _hasilUmur['bulan']!),
                  _buildVerticalStat("Hari", _hasilUmur['hari']!),
                  _buildVerticalStat("Jam", _hasilUmur['jam']!),
                  _buildVerticalStat("Menit", _hasilUmur['menit']!),
                ],
              ),
            ] else ...[
              Card(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    "Pilih tanggal lahir untuk melihat detail umur (Tahun, Bulan, Hari, Jam, Menit).",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalStat(String title, int count) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}
