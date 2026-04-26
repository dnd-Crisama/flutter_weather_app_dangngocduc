import 'package:flutter/material.dart';

class WeatherIcons {
  /// Get icon based on weather condition and time of day
  static IconData getIcon(String condition, {bool isNight = false}) {
    final normalizedCondition = condition.toLowerCase();

    if (isNight) {
      return _getNightIcon(normalizedCondition);
    }
    return _getDayIcon(normalizedCondition);
  }

  /// Day-specific icons for each weather condition
  static IconData _getDayIcon(String condition) {
    switch (condition) {
      case 'clear':
        return Icons.wb_sunny; // ☀️ Sunny
      case 'clouds':
        return Icons.wb_cloudy; // ☁️ Cloudy
      case 'rain':
        return Icons.cloud_download; // 🌧️ Rainy
      case 'drizzle':
        return Icons.grain; // 🌦️ Drizzle
      case 'thunderstorm':
        return Icons.flash_on; // ⛈️ Thunderstorm
      case 'snow':
        return Icons.ac_unit; // ❄️ Snow
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'dust':
      case 'sand':
      case 'ash':
      case 'tornado':
      case 'squall':
        return Icons.foggy; // 🌫️ Fog/Mist
      default:
        return Icons.wb_cloudy;
    }
  }

  /// Night-specific icons for each weather condition
  static IconData _getNightIcon(String condition) {
    switch (condition) {
      case 'clear':
        return Icons.nights_stay; // 🌙 Clear night
      case 'clouds':
        return Icons.cloud_queue; // ☁️ Cloudy night
      case 'rain':
        return Icons.cloud_download; // 🌧️ Rainy night
      case 'drizzle':
        return Icons.grain; // 🌦️ Drizzle night
      case 'thunderstorm':
        return Icons.flash_on; // ⛈️ Thunderstorm night
      case 'snow':
        return Icons.ac_unit; // ❄️ Snow night
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'dust':
      case 'sand':
      case 'ash':
      case 'tornado':
      case 'squall':
        return Icons.foggy; // 🌫️ Fog night
      default:
        return Icons.wb_cloudy;
    }
  }

  /// Check if it's night time based on sunrise/sunset
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

  /// Enhanced gradients with day/night variants
  static List<Color> getGradient(String condition, {bool isNight = false}) {
    final normalizedCondition = condition.toLowerCase();

    if (isNight) {
      return _getNightGradient(normalizedCondition);
    }
    return _getDayGradient(normalizedCondition);
  }

  /// Day gradients for each weather condition
  static List<Color> _getDayGradient(String condition) {
    switch (condition) {
      case 'clear':
        // Sunny day - warm orange to blue
        return [
          const Color.fromARGB(255, 255, 179, 71), // Orange
          const Color.fromARGB(255, 66, 165, 245), // Blue
        ];
      case 'clouds':
        // Cloudy - gray to light gray
        return [
          const Color.fromARGB(255, 176, 190, 197), // Gray blue
          const Color.fromARGB(255, 207, 216, 220), // Light gray
        ];
      case 'rain':
      case 'drizzle':
        // Rainy - dark blue to steel blue
        return [
          const Color.fromARGB(255, 57, 73, 171), // Dark blue
          const Color.fromARGB(255, 33, 150, 243), // Medium blue
        ];
      case 'thunderstorm':
        // Thunderstorm - very dark to dark gray
        return [
          const Color.fromARGB(255, 33, 33, 33), // Very dark
          const Color.fromARGB(255, 66, 66, 66), // Dark gray
        ];
      case 'snow':
        // Snow - light gray to snow white
        return [
          const Color.fromARGB(255, 176, 190, 197), // Gray
          const Color.fromARGB(255, 207, 216, 220), // Light gray/white
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
        // Fog - muted gray
        return [
          const Color.fromARGB(255, 144, 164, 174), // Muted gray
          const Color.fromARGB(255, 176, 190, 197), // Light gray
        ];
      default:
        // Default - blue gradient
        return [
          const Color.fromARGB(255, 21, 101, 192), // Deep blue
          const Color.fromARGB(255, 66, 165, 245), // Light blue
        ];
    }
  }

  /// Night gradients for each weather condition
  static List<Color> _getNightGradient(String condition) {
    switch (condition) {
      case 'clear':
        // Clear night - dark blue to navy
        return [
          const Color.fromARGB(255, 13, 71, 161), // Deep blue
          const Color.fromARGB(255, 25, 103, 210), // Navy blue
        ];
      case 'clouds':
        // Cloudy night - dark gray
        return [
          const Color.fromARGB(255, 33, 33, 33), // Dark
          const Color.fromARGB(255, 66, 66, 66), // Gray
        ];
      case 'rain':
      case 'drizzle':
        // Rainy night - very dark blue
        return [
          const Color.fromARGB(255, 13, 27, 42), // Very dark blue
          const Color.fromARGB(255, 33, 67, 102), // Dark blue
        ];
      case 'thunderstorm':
        // Thunderstorm night - extremely dark
        return [
          const Color.fromARGB(255, 0, 0, 0), // Black
          const Color.fromARGB(255, 33, 33, 33), // Very dark gray
        ];
      case 'snow':
        // Snow night - dark with slight blue tint
        return [
          const Color.fromARGB(255, 33, 57, 100), // Dark blue gray
          const Color.fromARGB(255, 66, 90, 130), // Lighter blue gray
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
        // Fog night - dark muted
        return [
          const Color.fromARGB(255, 33, 33, 33), // Dark
          const Color.fromARGB(255, 66, 66, 66), // Gray
        ];
      default:
        // Default night - midnight blue
        return [
          const Color.fromARGB(255, 0, 51, 102), // Midnight blue
          const Color.fromARGB(255, 13, 71, 161), // Navy
        ];
    }
  }

  /// Get wind direction in Vietnamese
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

  /// Get weather description emoji/icon
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
