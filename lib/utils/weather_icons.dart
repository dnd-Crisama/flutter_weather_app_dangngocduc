import 'package:flutter/material.dart';

class WeatherIcons {
  static IconData getIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.umbrella;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }

  // Mau gradient nen theo dieu kien thoi tiet
  static List<Color> getGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return [const Color(0xFF1565C0), const Color(0xFF42A5F5)];
      case 'clouds':
        return [const Color(0xFF546E7A), const Color(0xFF90A4AE)];
      case 'rain':
      case 'drizzle':
        return [const Color(0xFF1A237E), const Color(0xFF3949AB)];
      case 'thunderstorm':
        return [const Color(0xFF212121), const Color(0xFF424242)];
      case 'snow':
        return [const Color(0xFF455A64), const Color(0xFF90A4AE)];
      default:
        return [const Color(0xFF1565C0), const Color(0xFF42A5F5)];
    }
  }

  // Chuyen huong gio sang chu
  static String windDirection(int deg) {
    if (deg >= 337 || deg < 23) return 'Bắc';
    if (deg < 68) return 'Đông Bắc';
    if (deg < 113) return 'Đông';
    if (deg < 158) return 'Đông Nam';
    if (deg < 203) return 'Nam';
    if (deg < 248) return 'Tây Nam';
    if (deg < 293) return 'Tây';
    return 'Tây Bắc';
  }
}
