import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas1/utils/stopwatch_service.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopwatchService _service = StopwatchService();
  late Timer _uiTimer;

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
    super.dispose();
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

    String mStr = (minutes % 60).toString().padLeft(2, '0');
    String sStr = (seconds % 60).toString().padLeft(2, '0');
    String hStr = (hundreds % 100).toString().padLeft(2, '0');

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
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                      backgroundColor: isRunning 
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
                int previousLapTime = index < _service.laps.length - 1 
                    ? _service.laps[index + 1] 
                    : 0;
                int lapDuration = currentLapTime - previousLapTime;

                return ListTile(
                  leading: Text("Lap $lapNumber", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  title: Text(
                    "+ ${_formatTime(lapDuration)}", 
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Text(
                    _formatTime(currentLapTime), 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFeatures: [FontFeature.tabularFigures()]),
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