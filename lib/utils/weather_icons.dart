import 'package:flutter/material.dart';

class WeatherIcons {
  static IconData getIcon(String condition, {bool isNight = false}) {
    final normalizedCondition = condition.toLowerCase();

    if (isNight) {
      return _getNightIcon(normalizedCondition);
    }
    return _getDayIcon(normalizedCondition);
  }

  static IconData _getDayIcon(String condition) {
    switch (condition) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
        return Icons.cloud_download;
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
      case 'dust':
      case 'sand':
      case 'ash':
      case 'tornado':
      case 'squall':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }

  static IconData _getNightIcon(String condition) {
    switch (condition) {
      case 'clear':
        return Icons.nights_stay;
      case 'clouds':
        return Icons.cloud_queue;
      case 'rain':
        return Icons.cloud_download;
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
      case 'dust':
      case 'sand':
      case 'ash':
      case 'tornado':
      case 'squall':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }

  static bool isNightTime({
    required int sunrise,
    required int sunset,
    DateTime? currentTime,
  }) {
    currentTime ??= DateTime.now();
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);

    return currentTime.isBefore(sunriseTime) || currentTime.isAfter(sunsetTime);
  }

  static List<Color> getGradient(String condition, {bool isNight = false}) {
    final normalizedCondition = condition.toLowerCase();

    if (isNight) {
      return _getNightGradient(normalizedCondition);
    }
    return _getDayGradient(normalizedCondition);
  }

  static List<Color> _getDayGradient(String condition) {
    switch (condition) {
      case 'clear':
        return [
          const Color.fromARGB(255, 255, 179, 71),
          const Color.fromARGB(255, 66, 165, 245),
        ];
      case 'clouds':
        return [
          const Color.fromARGB(255, 176, 190, 197),
          const Color.fromARGB(255, 207, 216, 220),
        ];
      case 'rain':
      case 'drizzle':
        return [
          const Color.fromARGB(255, 57, 73, 171),
          const Color.fromARGB(255, 33, 150, 243),
        ];
      case 'thunderstorm':
        return [
          const Color.fromARGB(255, 33, 33, 33),
          const Color.fromARGB(255, 66, 66, 66),
        ];
      case 'snow':
        return [
          const Color.fromARGB(255, 176, 190, 197),
          const Color.fromARGB(255, 207, 216, 220),
        ];
      case 'mist':
      case 'fog':
      case 'haze':
      case 'smoke':
      case 'dust':
      case 'sand':
      case 'ash':
      case 'tornado':
      case 'squall':
        return [
          const Color.fromARGB(255, 144, 164, 174),
          const Color.fromARGB(255, 176, 190, 197),
        ];
      default:
        return [
          const Color.fromARGB(255, 21, 101, 192),
          const Color.fromARGB(255, 66, 165, 245),
        ];
    }
  }

  static List<Color> _getNightGradient(String condition) {
    switch (condition) {
      case 'clear':
        return [
          const Color.fromARGB(255, 13, 71, 161),
          const Color.fromARGB(255, 25, 103, 210),
        ];
      case 'clouds':
        return [
          const Color.fromARGB(255, 33, 33, 33),
          const Color.fromARGB(255, 66, 66, 66),
        ];
      case 'rain':
      case 'drizzle':
        return [
          const Color.fromARGB(255, 13, 27, 42),
          const Color.fromARGB(255, 33, 67, 102),
        ];
      case 'thunderstorm':
        return [
          const Color.fromARGB(255, 0, 0, 0),
          const Color.fromARGB(255, 33, 33, 33),
        ];
      case 'snow':
        return [
          const Color.fromARGB(255, 33, 57, 100),
          const Color.fromARGB(255, 66, 90, 130),
        ];
      case 'mist':
      case 'fog':
      case 'haze':
      case 'smoke':
      case 'dust':
      case 'sand':
      case 'ash':
      case 'tornado':
      case 'squall':
        return [
          const Color.fromARGB(255, 33, 33, 33),
          const Color.fromARGB(255, 66, 66, 66),
        ];
      default:
        return [
          const Color.fromARGB(255, 0, 51, 102),
          const Color.fromARGB(255, 13, 71, 161),
        ];
    }
  }

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

  static String getWeatherEmoji(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
        return '☁️';
      case 'rain':
        return '🌧️';
      case 'drizzle':
        return '🌦️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '❄️';
      case 'mist':
      case 'fog':
        return '🌫️';
      default:
        return '🌤️';
    }
  }
}
