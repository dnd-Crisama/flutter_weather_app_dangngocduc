import 'package:intl/intl.dart';

class DateFormatter {
  // Hien thi ngay day du: Thu 2, 01 thang 1 2025
  static String formatFull(DateTime dt) {
    return DateFormat('EEEE, d MMMM yyyy', 'vi').format(dt);
  }

  // Hien thi thu trong tuan: Thu 2
  static String formatWeekday(DateTime dt) {
    return DateFormat('EEEE', 'vi').format(dt);
  }

  // Hien thi ngay thang: 01/01
  static String formatDayMonth(DateTime dt) {
    return DateFormat('dd/MM').format(dt);
  }

  // Hien thi gio theo 12h hoac 24h
  static String formatTime(DateTime dt, {bool is24Hour = true}) {
    if (is24Hour) return DateFormat('HH:mm').format(dt);
    return DateFormat('h:mm a').format(dt);
  }

  // Hien thi gio ngan
  static String formatHour(DateTime dt, {bool is24Hour = true}) {
    if (is24Hour) return DateFormat('HH:mm').format(dt);
    return DateFormat('h a').format(dt);
  }

  // Hien thi thoi gian sunrise/sunset
  static String fromUnix(int unix, {bool is24Hour = true}) {
    final dt = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return formatTime(dt, is24Hour: is24Hour);
  }
}
