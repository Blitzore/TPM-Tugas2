import 'dart:async';

class StopwatchService {
  static final StopwatchService _instance = StopwatchService._internal();
  factory StopwatchService() => _instance;
  StopwatchService._internal();

  final Stopwatch _stopwatch = Stopwatch();
  final List<int> _laps = []; // Menyimpan riwayat milidetik

  void start() => _stopwatch.start();
  void stop() => _stopwatch.stop();
  
  void reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _laps.clear();
  }

  void addLap() {
    if (_stopwatch.isRunning) {
      _laps.insert(0, _stopwatch.elapsedMilliseconds); // Masukkan lap terbaru ke urutan teratas
    }
  }

  bool get isRunning => _stopwatch.isRunning;
  int get elapsedMilliseconds => _stopwatch.elapsedMilliseconds;
  List<int> get laps => List.unmodifiable(_laps);
}