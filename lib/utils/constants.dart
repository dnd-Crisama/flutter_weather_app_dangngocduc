class AppConstants {
  // Key SharedPreferences
  static const String cachedWeatherKey = 'cached_weather';
  static const String lastUpdateKey = 'last_update';
  static const String isCelsiusKey = 'is_celsius';
  static const String windUnitKey = 'wind_unit';
  static const String is24HourKey = 'is_24_hour';
  static const String searchHistoryKey = 'search_history';
  static const String favoritesKey = 'favorite_cities';
  static const String isDarkModeKey = 'is_dark_mode';

  // Cache hop le 30 phut
  static const int cacheValidMinutes = 30;

  // Toi da 5 thanh pho yeu thich, 10 lich su tim kiem
  static const int maxFavorites = 5;
  static const int maxHistory = 10;

  // Don vi gio
  static const String windMs = 'ms';
  static const String windKmh = 'kmh';
  static const String windMph = 'mph';
}
