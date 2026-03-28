import 'package:hijri/hijri_calendar.dart';

class DateLogic {
  static const List<String> pasaranJawa = ['Kliwon', 'Legi', 'Pahing', 'Pon', 'Wage'];
  static const List<String> hariMasehi = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
  static const List<String> wulanJawa = ['Suro', 'Sapar', 'Mulud', 'Bakda Mulud', 'Jumadil Awal', 'Jumadil Akhir', 'Rejeb', 'Ruwah', 'Pasa', 'Sawal', 'Sela', 'Besar'];

  // Konversi tanggal ke Hari & Weton
  static String getHariWeton(DateTime date) {
    // 1 Jan 1970 adalah Kamis (Wage)
    // DateTime.weekday: 1 (Senin) -> 7 (Minggu)
    int hariIndex = date.weekday % 7; // 0=Minggu, 1=Senin...
    
    // Perhitungan Weton (Pasaran) berdasarkan selisih hari dari Epoch (1 Jan 1970)
    DateTime epoch = DateTime(1970, 1, 1);
    int diffDays = date.difference(epoch).inDays;
    
    // 1 Jan 1970 = Wage (index 4 di array pasaran)
    int pasaranIndex = (diffDays + 4) % 5;
    if (pasaranIndex < 0) pasaranIndex += 5; // Handle before 1970

    return "${hariMasehi[hariIndex]} ${pasaranJawa[pasaranIndex]}";
  }

  // Konversi Masehi ke Tanggal Jawa (Berdasarkan Kalender Hijriah + Offset 512 Tahun)
  static String getTanggalJawa(DateTime date) {
    var hDate = HijriCalendar.fromDate(date);
    int jYear = hDate.hYear + 512;
    int jMonthIndex = hDate.hMonth - 1; // 1-based to 0-based
    return "${hDate.hDay} ${wulanJawa[jMonthIndex]} $jYear";
  }

  // Hitung Umur Detail
  static Map<String, int> getDetailUmur(DateTime birthDate) {
    DateTime now = DateTime.now();
    
    if (birthDate.isAfter(now)) {
      return {'tahun': 0, 'bulan': 0, 'hari': 0, 'jam': 0, 'menit': 0};
    }

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;
    int hours = now.hour - birthDate.hour;
    int minutes = now.minute - birthDate.minute;

    if (minutes < 0) {
      minutes += 60;
      hours--;
    }
    if (hours < 0) {
      hours += 24;
      days--;
    }
    if (days < 0) {
      // Pinjam hari dari bulan sebelumnya
      DateTime lastMonth = DateTime(now.year, now.month, 0);
      days += lastMonth.day;
      months--;
    }
    if (months < 0) {
      months += 12;
      years--;
    }

    return {
      'tahun': years,
      'bulan': months,
      'hari': days,
      'jam': hours,
      'menit': minutes,
    };
  }

  // Konversi Masehi ke Hijriah menggunakan library hijri (Dengan Adjustment +- hari)
  static String getHijriahDate(DateTime date, {int adjustment = 0}) {
    var adjustedDate = date.add(Duration(days: adjustment));
    var hDate = HijriCalendar.fromDate(adjustedDate);
    return hDate.toFormat("dd MMMM yyyy");
  }
}
