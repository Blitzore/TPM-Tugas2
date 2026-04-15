import 'package:flutter/material.dart';
import 'package:tugas1/utils/date_logic.dart';
import 'package:tugas1/utils/saka_calendar.dart';

class SakaPage extends StatefulWidget {
  const SakaPage({super.key});

  @override
  State<SakaPage> createState() => _SakaPageState();
}

class _SakaPageState extends State<SakaPage> {
  DateTime? _selectedDate;
  String _hasilSaka = '-';
  SakaCalendarSystem _selectedSystem = SakaCalendarSystem.india;

  String _systemLabel(SakaCalendarSystem system) {
    switch (system) {
      case SakaCalendarSystem.india:
        return 'Saka India';
      case SakaCalendarSystem.bali:
        return 'Saka Bali';
    }
  }

  void _updateHasil() {
    if (_selectedDate == null) return;
    setState(() {
      _hasilSaka = DateLogic.getSakaDate(
        _selectedDate!,
        system: _selectedSystem,
      );
    });
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _hasilSaka = DateLogic.getSakaDate(picked, system: _selectedSystem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Kalender Saka')),
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
                        Icon(
                          Icons.temple_hindu,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Pilih Tanggal Masehi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.date_range),
                      label: Text(
                        _selectedDate != null
                            ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                            : 'Tekan untuk Pilih Tanggal',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<SakaCalendarSystem>(
                      initialValue: _selectedSystem,
                      decoration: const InputDecoration(
                        labelText: 'Metode Perhitungan Saka',
                        prefixIcon: Icon(Icons.tune),
                      ),
                      items:
                          SakaCalendarSystem.values
                              .map(
                                (system) => DropdownMenuItem(
                                  value: system,
                                  child: Text(_systemLabel(system)),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        _selectedSystem = value;
                        _updateHasil();
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
                      'Hasil Tanggal Saka',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      _hasilSaka,
                      style: TextStyle(
                        fontSize: 30,
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
            const SizedBox(height: 16),
            Text(
              'Catatan: Mode India memakai kalender nasional India, mode Bali memakai padanan nama bulan Bali.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
