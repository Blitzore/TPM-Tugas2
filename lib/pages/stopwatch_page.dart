import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas1/utils/stopwatch_service.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopwatchService _service = StopwatchService();
  late Timer _uiTimer;
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _uiTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (mounted && _service.isRunning) setState(() {});
    });
  }

  @override
  void dispose() {
    _uiTimer.cancel();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  int _parseTimePart(TextEditingController controller) {
    final value = int.tryParse(controller.text.trim()) ?? 0;
    return value < 0 ? 0 : value;
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _applyInitialTime() {
    if (_service.isRunning) return;

    final rawMinutes = int.tryParse(_minuteController.text.trim()) ?? 0;
    final rawSeconds = int.tryParse(_secondController.text.trim()) ?? 0;

    if (rawMinutes < 0 || rawMinutes > 59) {
      _showValidationError("Menit harus di antara 0 sampai 59.");
      return;
    }

    if (rawSeconds < 0 || rawSeconds > 59) {
      _showValidationError("Detik harus di antara 0 sampai 59.");
      return;
    }

    final hours = _parseTimePart(_hourController);
    final minutes = rawMinutes;
    final seconds = rawSeconds;

    final duration = Duration(hours: hours, minutes: minutes, seconds: seconds);

    setState(() {
      _service.configureStartDuration(duration);
    });
  }

  void _toggleTimer() {
    setState(() => _service.isRunning ? _service.stop() : _service.start());
  }

  void _handleLeftButton() {
    setState(() {
      if (_service.isRunning) {
        _service.addLap();
      } else {
        _service.reset();
      }
    });
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    int days = (hours / 24).truncate();

    String mStr = (minutes % 60).toString().padLeft(2, '0');
    String sStr = (seconds % 60).toString().padLeft(2, '0');
    String hStr = (hundreds % 100).toString().padLeft(2, '0');
    String hourStr = (hours % 24).toString().padLeft(2, '0');

    if (days > 0) {
      return "${days}d $hourStr:$mStr:$sStr.$hStr";
    } else if (hours > 0) {
      return "$hourStr:$mStr:$sStr.$hStr";
    }
    return "$mStr:$sStr.$hStr";
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _service.isRunning;
    final hasStarted = _service.elapsedMilliseconds > 0;

    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch Profesional")),
      body: Column(
        children: [
          // --- BAGIAN TIMER ATAS ---
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              _formatTime(_service.elapsedMilliseconds),
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.primary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Set Waktu Awal (sebelum Start)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _hourController,
                            enabled: !_service.isRunning,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(labelText: "Jam"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _minuteController,
                            enabled: !_service.isRunning,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: "Menit",
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _secondController,
                            enabled: !_service.isRunning,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: "Detik",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed:
                            _service.isRunning ? null : _applyInitialTime,
                        child: const Text("Terapkan"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- TOMBOL KONTROL ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: hasStarted ? _handleLeftButton : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    child: Text(isRunning ? "LAP" : "RESET"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _toggleTimer,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:
                          isRunning
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(isRunning ? "STOP" : "START"),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // --- DAFTAR LAP ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _service.laps.length,
              itemBuilder: (context, index) {
                // Menghitung urutan lap (lap terbaru di atas)
                int lapNumber = _service.laps.length - index;
                int currentLapTime = _service.laps[index];

                // Menghitung selisih (durasi) lap ini dengan lap sebelumnya
                int previousLapTime =
                    index < _service.laps.length - 1
                        ? _service.laps[index + 1]
                        : _service.initialOffsetMilliseconds;
                int lapDuration = currentLapTime - previousLapTime;

                return ListTile(
                  leading: Text(
                    "Lap $lapNumber",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(
                    "+ ${_formatTime(lapDuration)}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Text(
                    _formatTime(currentLapTime),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
