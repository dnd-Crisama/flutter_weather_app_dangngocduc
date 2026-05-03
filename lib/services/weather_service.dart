import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/hourly_weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeatherByCity(String city) async {
    final url = Uri.parse(ApiConfig.weatherByCity(city));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    return _parseWeather(response);
  }

  Future<WeatherModel> getWeatherByCoords(double lat, double lon) async {
    final url = Uri.parse(ApiConfig.weatherByCoords(lat, lon));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    return _parseWeather(response);
  }

  WeatherModel _parseWeather(http.Response response) {
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Không tìm thấy thành phố. Kiểm tra lại tên!');
    } else if (response.statusCode == 401) {
      throw Exception('API key không hợp lệ. Kiểm tra lại key!');
    } else if (response.statusCode == 429) {
      throw Exception('Đã vượt giới hạn API. Thử lại sau!');
    } else {
      throw Exception('Lỗi server: ${response.statusCode}');
    }
  }

  Future<List<ForecastModel>> getForecastByCity(String city) async {
    final url = Uri.parse(ApiConfig.forecastByCity(city));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    return _parseForecast(response);
  }

  Future<List<ForecastModel>> getForecastByCoords(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(ApiConfig.forecastByCoords(lat, lon));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    return _parseForecast(response);
  }

  List<ForecastModel> _parseForecast(http.Response response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['list'] as List;
      return list.map((item) => ForecastModel.fromJson(item)).toList();
    } else {
      throw Exception('Không lấy được dự báo thời tiết');
    }
  }

  Future<List<HourlyWeatherModel>> getHourlyByCity(String city) async {
    final url = Uri.parse(ApiConfig.forecastByCity(city));
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['list'] as List;
      return list
          .take(8)
          .map((item) => HourlyWeatherModel.fromJson(item))
          .toList();
    }
    throw Exception('Không lấy được dự báo theo giờ');
  }
}
