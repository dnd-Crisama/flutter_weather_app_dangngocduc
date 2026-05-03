import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/hourly_weather_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../services/connectivity_service.dart';
import '../utils/constants.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;
  final ConnectivityService _connectivityService;

  WeatherModel? currentWeather;
  List<ForecastModel> forecast = [];
  List<HourlyWeatherModel> hourlyForecast = [];
  WeatherState state = WeatherState.initial;
  String errorMessage = '';

  bool isCelsius = true;
  String windUnit = AppConstants.windMs;
  bool is24Hour = true;
  bool isDarkMode = false;

  bool isShowingCache = false;
  DateTime? lastUpdateTime;
  List<String> searchHistory = [];
  List<String> favorites = [];

  WeatherProvider({
    required WeatherService weatherService,
    required LocationService locationService,
    required StorageService storageService,
    required ConnectivityService connectivityService,
  }) : _weatherService = weatherService,
       _locationService = locationService,
       _storageService = storageService,
       _connectivityService = connectivityService {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    isCelsius = await _storageService.loadIsCelsius();
    windUnit = await _storageService.loadWindUnit();
    is24Hour = await _storageService.loadIs24Hour();
    isDarkMode = await _storageService.loadDarkMode();
    searchHistory = await _storageService.loadSearchHistory();
    favorites = await _storageService.loadFavorites();
    notifyListeners();
  }

  Future<void> fetchByLocation() async {
    state = WeatherState.loading;
    isShowingCache = false;
    notifyListeners();

    try {
      final isOnline = await _connectivityService.isConnected();
      if (!isOnline) {
        await _tryLoadCache(isOffline: true);
        return;
      }

      final position = await _locationService.getCurrentPosition();
      currentWeather = await _weatherService.getWeatherByCoords(
        position.latitude,
        position.longitude,
      );
      forecast = await _weatherService.getForecastByCoords(
        position.latitude,
        position.longitude,
      );
      hourlyForecast = forecast
          .take(8)
          .map(
            (f) => HourlyWeatherModel(
              dateTime: f.dateTime,
              temperature: f.temperature,
              icon: f.icon,
              description: f.description,
              pop: f.pop,
            ),
          )
          .toList();

      await _storageService.saveWeather(currentWeather!);
      lastUpdateTime = DateTime.now();
      state = WeatherState.loaded;
      errorMessage = '';
    } catch (e) {
      final loaded = await _tryLoadCache();
      if (!loaded) {
        state = WeatherState.error;
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      }
    }

    notifyListeners();
  }

  Future<void> fetchByCity(String city) async {
    state = WeatherState.loading;
    isShowingCache = false;
    notifyListeners();

    try {
      final isOnline = await _connectivityService.isConnected();
      if (!isOnline) {
        await _tryLoadCache(isOffline: true);
        return;
      }

      currentWeather = await _weatherService.getWeatherByCity(city);
      forecast = await _weatherService.getForecastByCity(city);
      hourlyForecast = forecast
          .take(8)
          .map(
            (f) => HourlyWeatherModel(
              dateTime: f.dateTime,
              temperature: f.temperature,
              icon: f.icon,
              description: f.description,
              pop: f.pop,
            ),
          )
          .toList();

      await _storageService.saveWeather(currentWeather!);
      lastUpdateTime = DateTime.now();
      _addToHistory(city);
      state = WeatherState.loaded;
      errorMessage = '';
    } catch (e) {
      state = WeatherState.error;
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    }

    notifyListeners();
  }

  Future<bool> _tryLoadCache({bool isOffline = false}) async {
    final cached = await _storageService.loadCachedWeather();
    if (cached != null) {
      currentWeather = cached;
      lastUpdateTime = await _storageService.getLastUpdateTime();
      isShowingCache = true;
      state = WeatherState.loaded;
      if (isOffline) {
        errorMessage = 'Hiển thị dữ liệu cũ do không có kết nối internet';
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> refresh() async {
    if (currentWeather != null) {
      await fetchByCity(currentWeather!.cityName);
    } else {
      await fetchByLocation();
    }
  }

  List<ForecastModel> get dailyForecast {
    final Map<String, ForecastModel> daily = {};
    for (final item in forecast) {
      final key =
          '${item.dateTime.year}-${item.dateTime.month}-${item.dateTime.day}';
      if (!daily.containsKey(key)) {
        daily[key] = item;
      } else {
        final diffNew = (item.dateTime.hour - 12).abs();
        final diffOld = (daily[key]!.dateTime.hour - 12).abs();
        if (diffNew < diffOld) daily[key] = item;
      }
    }
    return daily.values.toList();
  }

  double convertTemp(double celsius) {
    if (isCelsius) return celsius;
    return (celsius * 9 / 5) + 32;
  }

  String get tempUnit => isCelsius ? 'C' : 'F';

  String convertWind(double ms) {
    switch (windUnit) {
      case AppConstants.windKmh:
        return '${(ms * 3.6).toStringAsFixed(1)} km/h';
      case AppConstants.windMph:
        return '${(ms * 2.237).toStringAsFixed(1)} mph';
      default:
        return '${ms.toStringAsFixed(1)} m/s';
    }
  }

  void toggleTempUnit() {
    isCelsius = !isCelsius;
    _storageService.saveIsCelsius(isCelsius);
    notifyListeners();
  }

  void setWindUnit(String unit) {
    windUnit = unit;
    _storageService.saveWindUnit(unit);
    notifyListeners();
  }

  void toggleTimeFormat() {
    is24Hour = !is24Hour;
    _storageService.saveIs24Hour(is24Hour);
    notifyListeners();
  }

  void _addToHistory(String city) {
    searchHistory.remove(city);
    searchHistory.insert(0, city);
    if (searchHistory.length > AppConstants.maxHistory) {
      searchHistory = searchHistory.sublist(0, AppConstants.maxHistory);
    }
    _storageService.saveSearchHistory(searchHistory);
  }

  void clearHistory() {
    searchHistory.clear();
    _storageService.saveSearchHistory(searchHistory);
    notifyListeners();
  }

  void toggleFavorite(String city) {
    if (favorites.contains(city)) {
      favorites.remove(city);
    } else {
      if (favorites.length >= AppConstants.maxFavorites) return;
      favorites.add(city);
    }
    _storageService.saveFavorites(favorites);
    notifyListeners();
  }

  bool isFavorite(String city) => favorites.contains(city);

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    _storageService.saveDarkMode(isDarkMode);
    notifyListeners();
  }
}
