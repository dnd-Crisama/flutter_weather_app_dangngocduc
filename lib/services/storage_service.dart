import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../models/weather_model.dart';

class StorageService {
  Future<void> saveWeather(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.cachedWeatherKey,
      weather.toJsonString(),
    );
    await prefs.setInt(
      AppConstants.lastUpdateKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<WeatherModel?> loadCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(AppConstants.cachedWeatherKey);
    if (data == null) return null;
    try {
      return WeatherModel.fromJsonString(data);
    } catch (_) {
      return null;
    }
  }

  Future<bool> isCacheValid() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdate = prefs.getInt(AppConstants.lastUpdateKey);
    if (lastUpdate == null) return false;
    final diff = DateTime.now().millisecondsSinceEpoch - lastUpdate;
    return diff < AppConstants.cacheValidMinutes * 60 * 1000;
  }

  Future<DateTime?> getLastUpdateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getInt(AppConstants.lastUpdateKey);
    if (ts == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(ts);
  }

  Future<void> saveIsCelsius(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.isCelsiusKey, value);
  }

  Future<bool> loadIsCelsius() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isCelsiusKey) ?? true;
  }

  Future<void> saveWindUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.windUnitKey, unit);
  }

  Future<String> loadWindUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.windUnitKey) ?? AppConstants.windMs;
  }

  Future<void> saveIs24Hour(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.is24HourKey, value);
  }

  Future<bool> loadIs24Hour() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.is24HourKey) ?? true;
  }

  Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(AppConstants.searchHistoryKey, history);
  }

  Future<List<String>> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(AppConstants.searchHistoryKey) ?? [];
  }

  Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(AppConstants.favoritesKey, favorites);
  }

  Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(AppConstants.favoritesKey) ?? [];
  }

  Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.isDarkModeKey, value);
  }

  Future<bool> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isDarkModeKey) ?? false;
  }
}
