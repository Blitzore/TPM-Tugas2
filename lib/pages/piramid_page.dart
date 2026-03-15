import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas1/utils/math_logic.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _sisiController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _tipeKalkulasi = 'Volume';
  String _satuanSisi = 'cm';
  String _satuanTinggi = 'cm';
  String _satuanHasil = 'cm';
  String _hasil = "-";
  String _labelHasil = "Hasil";

  double _convertToMeters(double value, String unit) {
    switch (unit) {
      case 'mm': return value / 1000;
      case 'cm': return value / 100;
      case 'km': return value * 1000;
      case 'm': 
      default: return value;
    }
  }

  double _convertFromMeters(double valueInMeters, String targetUnit, bool isVolume) {
    double factor = 1.0;
    switch (targetUnit) {
      case 'mm': factor = 1000.0; break;
      case 'cm': factor = 100.0; break;
      case 'km': factor = 0.001; break;
      case 'm': 
      default: factor = 1.0; break;
    }
    
    return isVolume 
        ? valueInMeters * (factor * factor * factor) 
        : valueInMeters * (factor * factor);
  }

  void _hitung() {
    FocusScope.of(context).unfocus(); 
    
    if (_formKey.currentState!.validate()) {
      double? sisiRaw = double.tryParse(_sisiController.text.replaceAll(',', '.'));
      double? tinggiRaw = double.tryParse(_tinggiController.text.replaceAll(',', '.'));

      if (sisiRaw != null && tinggiRaw != null) {
        setState(() {
          double sisiM = _convertToMeters(sisiRaw, _satuanSisi);
          double tinggiM = _convertToMeters(tinggiRaw, _satuanTinggi);

          if (_tipeKalkulasi == 'Volume') {
            double volM3 = MathLogic.hitungVolumePiramid(sisiM, tinggiM);
            double finalVol = _convertFromMeters(volM3, _satuanHasil, true);
            _hasil = "${MathLogic.formatCleanDouble(finalVol)} $_satuanHasil³";
            _labelHasil = "Volume Piramida";
          } else {
            double luasM2 = MathLogic.hitungLuasPermukaanPiramid(sisiM, tinggiM);
            double finalLuas = _convertFromMeters(luasM2, _satuanHasil, false);
            _hasil = "${MathLogic.formatCleanDouble(finalLuas)} $_satuanHasil²";
            _labelHasil = "Luas Permukaan Piramida";
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Input tidak valid."),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Widget _buildInlineUnitDropdown(String value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).colorScheme.primary),
          items: ['mm', 'cm', 'm', 'km'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary, 
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Piramida")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _tipeKalkulasi,
                        decoration: const InputDecoration(
                          labelText: "Mode Kalkulasi",
                          prefixIcon: Icon(Icons.science_outlined),
                        ),
                        items: ['Volume', 'Luas Permukaan']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
                            .toList(),
                        onChanged: (val) => setState(() {
                          _tipeKalkulasi = val!;
                          _hasil = "-"; 
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 4, 
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _satuanHasil,
                        decoration: const InputDecoration(labelText: "Satuan Hasil"),
                        items: ['mm', 'cm', 'm', 'km']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => setState(() {
                          _satuanHasil = val!;
                          _hasil = "-"; 
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                          Icon(Icons.change_history, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          const Text("Dimensi Ukuran", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(height: 24),
                      TextFormField(
                        controller: _sisiController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                        decoration: InputDecoration(
                          labelText: "Panjang Sisi Alas",
                          prefixIcon: const Icon(Icons.straighten),
                          suffixIcon: _buildInlineUnitDropdown(_satuanSisi, (val) => setState(() => _satuanSisi = val!)),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty ? "Wajib diisi" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _tinggiController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _hitung(),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                        decoration: InputDecoration(
                          labelText: "Tinggi Piramida",
                          prefixIcon: const Icon(Icons.height),
                          suffixIcon: _buildInlineUnitDropdown(_satuanTinggi, (val) => setState(() => _satuanTinggi = val!)),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty ? "Wajib diisi" : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _hitung,
                        icon: const Icon(Icons.calculate),
                        label: Text("HITUNG ${_tipeKalkulasi.toUpperCase()}"),
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
                      _labelHasil,
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