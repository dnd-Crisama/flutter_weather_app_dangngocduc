import 'package:intl/intl.dart';

class DateFormatter {
  static String formatFull(DateTime dt) {
    return DateFormat('EEEE, d MMMM yyyy', 'vi').format(dt);
  }

  static String formatWeekday(DateTime dt) {
    return DateFormat('EEEE', 'vi').format(dt);
  }

  static String formatDayMonth(DateTime dt) {
    return DateFormat('dd/MM').format(dt);
  }

  static String formatTime(DateTime dt, {bool is24Hour = true}) {
    if (is24Hour) return DateFormat('HH:mm').format(dt);
    return DateFormat('h:mm a').format(dt);
  }

  static String formatHour(DateTime dt, {bool is24Hour = true}) {
    if (is24Hour) return DateFormat('HH:mm').format(dt);
    return DateFormat('h a').format(dt);
  }

  static String fromUnix(int unix, {bool is24Hour = true}) {
    final dt = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return formatTime(dt, is24Hour: is24Hour);
  }
}
