class StopwatchService {
  static final StopwatchService _instance = StopwatchService._internal();
  factory StopwatchService() => _instance;
  StopwatchService._internal();

  final Stopwatch _stopwatch = Stopwatch();
  final List<int> _laps = []; // Menyimpan riwayat milidetik
  int _initialOffsetMilliseconds = 0;

  void start() => _stopwatch.start();
  void stop() => _stopwatch.stop();

  void reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _laps.clear();
    _initialOffsetMilliseconds = 0;
  }

  bool configureStartDuration(Duration duration) {
    if (_stopwatch.isRunning) return false;

    _stopwatch.reset();
    _laps.clear();
    _initialOffsetMilliseconds = duration.inMilliseconds;
    return true;
  }

  void addLap() {
    if (_stopwatch.isRunning) {
      _laps.insert(
        0,
        elapsedMilliseconds,
      ); // Masukkan lap terbaru ke urutan teratas
    }
  }

  bool get isRunning => _stopwatch.isRunning;
  int get elapsedMilliseconds =>
      _initialOffsetMilliseconds + _stopwatch.elapsedMilliseconds;
  int get initialOffsetMilliseconds => _initialOffsetMilliseconds;
  List<int> get laps => List.unmodifiable(_laps);
}
