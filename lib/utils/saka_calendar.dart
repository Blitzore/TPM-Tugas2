enum SakaCalendarSystem { india, bali }

class SakaDate {
  const SakaDate({
    required this.year,
    required this.month,
    required this.day,
    this.customMonthName,
  });

  final int year;
  final int month;
  final int day;
  final String? customMonthName;

  static const List<String> monthNames = [
    'Caitra',
    'Vaisakha',
    'Jyaistha',
    'Asadha',
    'Sravana',
    'Bhadra',
    'Asvina',
    'Kartika',
    'Agrahayana',
    'Pausa',
    'Magha',
    'Phalguna',
  ];

  static const List<String> baliMonthNames = [
    'Kasa',
    'Karo',
    'Katiga',
    'Kapat',
    'Kalima',
    'Kanem',
    'Kapitu',
    'Kawolu',
    'Kasanga',
    'Kadasa',
    'Desta',
    'Sadha',
  ];

  String format({SakaCalendarSystem system = SakaCalendarSystem.india}) {
    final months =
        system == SakaCalendarSystem.bali ? baliMonthNames : monthNames;
    final monthLabel =
        customMonthName ??
        ((month >= 1 && month <= months.length)
            ? months[month - 1]
            : months[((month - 1) % months.length + months.length) %
                months.length]);
    return '$day $monthLabel $year Saka';
  }
}

class SakaCalendar {
  static SakaDate fromGregorian(
    DateTime date, {
    SakaCalendarSystem system = SakaCalendarSystem.india,
  }) {
    switch (system) {
      case SakaCalendarSystem.india:
        return _fromGregorianIndia(date);
      case SakaCalendarSystem.bali:
        return _fromGregorianBali(date);
    }
  }

  static SakaDate _fromGregorianIndia(DateTime date) {
    final DateTime normalizedDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
    );
    final bool currentGregorianLeap = _isGregorianLeapYear(normalizedDate.year);
    final DateTime sakaNewYearCurrent = DateTime.utc(
      normalizedDate.year,
      3,
      currentGregorianLeap ? 21 : 22,
    );

    late final int sakaYear;
    late final DateTime sakaYearStart;
    late final bool sakaYearBasedOnLeap;

    if (normalizedDate.isBefore(sakaNewYearCurrent)) {
      sakaYear = normalizedDate.year - 79;
      final int prevYear = normalizedDate.year - 1;
      sakaYearBasedOnLeap = _isGregorianLeapYear(prevYear);
      sakaYearStart = DateTime.utc(prevYear, 3, sakaYearBasedOnLeap ? 21 : 22);
    } else {
      sakaYear = normalizedDate.year - 78;
      sakaYearBasedOnLeap = currentGregorianLeap;
      sakaYearStart = sakaNewYearCurrent;
    }

    int elapsedDays = normalizedDate.difference(sakaYearStart).inDays;
    final List<int> monthLengths = _monthLengths(sakaYearBasedOnLeap);

    int month = 1;
    for (final int length in monthLengths) {
      if (elapsedDays < length) break;
      elapsedDays -= length;
      month++;
    }

    return SakaDate(year: sakaYear, month: month, day: elapsedDays + 1);
  }

  static SakaDate _fromGregorianBali(DateTime date) {
    const int dayNgunaRatri = 63;
    final DateTime skStart = DateTime(1993, 1, 24);
    final DateTime skEnd = DateTime(2003, 1, 3);

    final normalizedDate = DateTime(date.year, date.month, date.day);
    final pivot = _bestBaliPivot(normalizedDate);

    final int dayDiff = _deltaDay(pivot.date, normalizedDate);
    final int daySkip = (dayDiff / dayNgunaRatri).ceil();
    final int dayTotal = pivot.sasihDay + dayDiff + daySkip;

    final int pivotOffset =
        (pivot.sasihDay == 0 && pivot.ngunaRatriDay == 0) ? 0 : 1;
    int totalSasih = (dayTotal / 30).ceil() - pivotOffset;

    int currentSasih = pivot.sasihId;
    int currentSaka = pivot.saka - (currentSasih == 9 ? 1 : 0);
    int nampihCount = pivot.isNampihSasih ? 1 : 0;

    bool inSK = !pivot.date.isBefore(skStart) && pivot.date.isBefore(skEnd);

    while (totalSasih != 0) {
      if (dayDiff >= 0) {
        if (nampihCount == 0 || nampihCount == 2) {
          nampihCount = 0;
          currentSasih = _mod(currentSasih + 1, 12);
        }

        totalSasih -= 1;

        if (currentSasih == 9 && nampihCount == 0) {
          currentSaka += 1;
        }

        if (currentSasih == 7 && currentSaka == 1914) {
          inSK = true;
        } else if (currentSasih == 7 && currentSaka == 1924) {
          inSK = false;
        }
      } else {
        if (nampihCount == 0 || nampihCount == 2) {
          nampihCount = 0;
          currentSasih = _mod(currentSasih - 1, 12);
        }

        totalSasih += 1;

        if (currentSasih == 8 && nampihCount == 0) {
          currentSaka -= 1;
        }

        if (currentSasih == 6 && currentSaka == 1914) {
          inSK = false;
        } else if (currentSasih == 6 && currentSaka == 1924) {
          inSK = true;
        }
      }

      final mod19 = _mod(currentSaka, 19);
      switch (mod19) {
        case 0:
        case 6:
        case 11:
          if (currentSasih == 10 && !inSK) {
            if (currentSaka != 1925) {
              nampihCount++;
            }
          }
          break;
        case 3:
        case 8:
        case 14:
        case 16:
          if (currentSasih == 11 && !inSK) {
            nampihCount++;
          }
          break;
        case 2:
        case 10:
          if (currentSasih == 10 && inSK) {
            nampihCount++;
          }
          break;
        case 4:
          if (currentSasih == 2 && inSK) {
            nampihCount++;
          }
          break;
        case 7:
          if (currentSasih == 0 && inSK) {
            nampihCount++;
          }
          break;
        case 13:
          if (currentSasih == 9 && inSK) {
            nampihCount++;
          }
          break;
        case 15:
          if (currentSasih == 1 && inSK) {
            nampihCount++;
          }
          break;
        case 18:
          if (currentSasih == 11 && inSK) {
            nampihCount++;
          }
          break;
      }
    }

    int dayValue = _mod(dayTotal, 30);
    dayValue = _mod(dayValue, 15);
    dayValue = dayValue == 0 ? 15 : dayValue;

    final bool isNampihMonth =
        (dayTotal >= 0) ? (nampihCount == 2) : (nampihCount == 1);

    String? customMonthName;
    if (isNampihMonth) {
      switch (currentSasih) {
        case 10:
          customMonthName =
              currentSaka < 1914 ? 'Mala Destha' : 'Nampih Destha';
          break;
        case 11:
          customMonthName = currentSaka < 1914 ? 'Mala Sadha' : 'Nampih Sadha';
          break;
        case 2:
          customMonthName = 'Nampih Katiga';
          break;
        case 0:
          customMonthName = 'Nampih Kasa';
          break;
        case 9:
          customMonthName = 'Nampih Kadasa';
          break;
        case 1:
          customMonthName = 'Nampih Karo';
          break;
      }
    }

    return SakaDate(
      year: currentSaka,
      month: currentSasih + 1,
      day: dayValue,
      customMonthName: customMonthName,
    );
  }

  static int _mod(int a, int b) => ((a % b) + b) % b;

  static int _deltaDay(DateTime start, DateTime end) {
    final s = DateTime.utc(start.year, start.month, start.day);
    final e = DateTime.utc(end.year, end.month, end.day);
    return e.difference(s).inDays;
  }

  static _BaliPivot _bestBaliPivot(DateTime date) {
    final pangalantakaPaing = DateTime(2000, 1, 6);
    if (date.isBefore(pangalantakaPaing)) {
      return _BaliPivot(
        date: DateTime(1971, 1, 27),
        pawukonDay: 3,
        sasihDay: 0,
        ngunaRatriDay: 0,
        saka: 1892,
        sasihId: 6,
        isNampihSasih: false,
      );
    }

    return _BaliPivot(
      date: DateTime(2000, 1, 18),
      pawukonDay: 86,
      sasihDay: 12,
      ngunaRatriDay: 0,
      saka: 1921,
      sasihId: 6,
      isNampihSasih: false,
    );
  }

  static DateTime toGregorian(SakaDate sakaDate) {
    if (sakaDate.month < 1 || sakaDate.month > 12) {
      throw ArgumentError('Bulan Saka harus 1 sampai 12.');
    }

    final int gregorianYear = sakaDate.year + 78;
    final bool leap = _isGregorianLeapYear(gregorianYear);
    final List<int> monthLengths = _monthLengths(leap);

    final int maxDay = monthLengths[sakaDate.month - 1];
    if (sakaDate.day < 1 || sakaDate.day > maxDay) {
      throw ArgumentError('Tanggal tidak valid untuk bulan Saka tersebut.');
    }

    final DateTime sakaYearStart = DateTime.utc(
      gregorianYear,
      3,
      leap ? 21 : 22,
    );
    int daysOffset = sakaDate.day - 1;
    for (int month = 1; month < sakaDate.month; month++) {
      daysOffset += monthLengths[month - 1];
    }

    return sakaYearStart.add(Duration(days: daysOffset));
  }

  static List<int> _monthLengths(bool leap) {
    return [leap ? 31 : 30, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30];
  }

  static bool _isGregorianLeapYear(int year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    return year % 4 == 0;
  }
}

class _BaliPivot {
  const _BaliPivot({
    required this.date,
    required this.pawukonDay,
    required this.sasihDay,
    required this.ngunaRatriDay,
    required this.saka,
    required this.sasihId,
    required this.isNampihSasih,
  });

  final DateTime date;
  final int pawukonDay;
  final int sasihDay;
  final int ngunaRatriDay;
  final int saka;
  final int sasihId;
  final bool isNampihSasih;
}
