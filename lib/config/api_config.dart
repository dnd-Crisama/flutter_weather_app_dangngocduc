import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get apiKey => dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String iconBaseUrl = 'https://openweathermap.org/img/wn/';

  // URL lay thoi tiet hien tai theo ten thanh pho
  static String weatherByCity(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey&units=metric&lang=vi';

  // URL lay thoi tiet theo toa do GPS
  static String weatherByCoords(double lat, double lon) =>
      '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=vi';

  // URL lay du bao 5 ngay theo ten thanh pho
  static String forecastByCity(String city) =>
      '$baseUrl/forecast?q=$city&appid=$apiKey&units=metric&lang=vi';

  // URL lay du bao theo toa do GPS
  static String forecastByCoords(double lat, double lon) =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=vi';

  // URL icon thoi tiet
  static String iconUrl(String code) => '${iconBaseUrl}$code@2x.png';
  static String iconUrlLarge(String code) => '${iconBaseUrl}$code@4x.png';
}
