import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/hourly_weather_model.dart';
import 'package:weather_app/utils/date_formatter.dart';
import 'package:weather_app/utils/weather_icons.dart';

// Sample JSON data for testing
final sampleWeatherJson = {
  'name': 'Ho Chi Minh City',
  'sys': {'country': 'VN', 'sunrise': 1619083200, 'sunset': 1619126400},
  'main': {
    'temp': 25.0,
    'feels_like': 24.5,
    'temp_min': 22.0,
    'temp_max': 28.0,
    'humidity': 70,
    'pressure': 1013,
  },
  'wind': {'speed': 5.2, 'deg': 180},
  'clouds': {'all': 50},
  'visibility': 10000,
  'weather': [
    {'main': 'Clouds', 'description': 'Áng mây rải rác', 'icon': '02d'},
  ],
  'dt': 1619104800,
};

final sampleForecastJson = {
  'dt': 1619104800,
  'main': {'temp': 25.0, 'temp_min': 22.0, 'temp_max': 28.0, 'humidity': 70},
  'weather': [
    {'main': 'Rain', 'description': 'Có mưa', 'icon': '10d'},
  ],
  'wind': {'speed': 4.5},
  'pop': 0.8,
};

final sampleHourlyJson = {
  'dt': 1619104800,
  'main': {'temp': 26.0},
  'weather': [
    {'main': 'Clear', 'description': 'Trời quang đãng', 'icon': '01d'},
  ],
  'pop': 0.0,
};

void main() {
  setUpAll(() async {
    // Initialize locale data for date formatting tests
    await initializeDateFormatting('vi');
  });

  group('WeatherModel Tests', () {
    test('Parse weather JSON correctly', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);

      expect(weather.cityName, 'Ho Chi Minh City');
      expect(weather.country, 'VN');
      expect(weather.temperature, 25.0);
      expect(weather.feelsLike, 24.5);
      expect(weather.tempMin, 22.0);
      expect(weather.tempMax, 28.0);
      expect(weather.humidity, 70);
      expect(weather.windSpeed, 5.2);
      expect(weather.windDeg, 180);
      expect(weather.pressure, 1013);
      expect(weather.visibility, 10000);
      expect(weather.cloudiness, 50);
      expect(weather.description, 'Áng mây rải rác');
      expect(weather.icon, '02d');
      expect(weather.mainCondition, 'Clouds');
    });

    test('Handle missing optional fields in weather JSON', () {
      final jsonWithMissing = {
        'name': 'Test City',
        'sys': {'country': 'XX', 'sunrise': 0, 'sunset': 0},
        'main': {
          'temp': 20.0,
          'feels_like': 20.0,
          'temp_min': 18.0,
          'temp_max': 22.0,
          'humidity': 60,
          'pressure': 1010,
        },
        'wind': {'speed': 3.0, 'deg': 0},
        'weather': [
          {'main': 'Clear', 'description': 'Trời đep', 'icon': '01d'},
        ],
        'dt': 1619104800,
      };

      final weather = WeatherModel.fromJson(jsonWithMissing);
      expect(weather.cityName, 'Test City');
      expect(weather.visibility, 0); // Default value
      expect(weather.cloudiness, 0); // Default value
    });

    test('Convert weather to JSON correctly', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);
      final json = weather.toJson();

      expect(json['name'], 'Ho Chi Minh City');
      expect(json['sys']['country'], 'VN');
      expect(json['main']['temp'], 25.0);
    });
  });

  group('ForecastModel Tests', () {
    test('Parse forecast JSON correctly', () {
      final forecast = ForecastModel.fromJson(sampleForecastJson);

      expect(forecast.temperature, 25.0);
      expect(forecast.tempMin, 22.0);
      expect(forecast.tempMax, 28.0);
      expect(forecast.humidity, 70);
      expect(forecast.description, 'Có mưa');
      expect(forecast.icon, '10d');
      expect(forecast.mainCondition, 'Rain');
      expect(forecast.windSpeed, 4.5);
      expect(forecast.pop, 0.8);
    });

    test('Handle rain probability (pop) correctly', () {
      final json1 = {...sampleForecastJson, 'pop': null};
      final forecast1 = ForecastModel.fromJson(json1);
      expect(forecast1.pop, 0.0);

      final json2 = {...sampleForecastJson, 'pop': 0.5};
      final forecast2 = ForecastModel.fromJson(json2);
      expect(forecast2.pop, 0.5);
    });
  });

  group('HourlyWeatherModel Tests', () {
    test('Parse hourly weather JSON correctly', () {
      final hourly = HourlyWeatherModel.fromJson(sampleHourlyJson);

      expect(hourly.temperature, 26.0);
      expect(hourly.description, 'Trời quang đãng');
      expect(hourly.icon, '01d');
      expect(hourly.pop, 0.0);
    });

    test('Handle missing pop field', () {
      final json = {...sampleHourlyJson};
      json.remove('pop');
      final hourly = HourlyWeatherModel.fromJson(json);
      expect(hourly.pop, 0.0);
    });
  });

  group('WeatherService Tests', () {
    test('Parse current weather successfully', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);

      expect(weather.cityName, isNotEmpty);
      expect(weather.temperature, greaterThan(0));
      expect(weather.country, isNotEmpty);
    });

    test('Parse forecast list successfully', () {
      final forecast = ForecastModel.fromJson(sampleForecastJson);

      expect(forecast.temperature, greaterThan(0));
      expect(forecast.mainCondition, isNotEmpty);
      expect(forecast.icon, isNotEmpty);
    });

    test('Parse hourly weather list successfully', () {
      final hourly = HourlyWeatherModel.fromJson(sampleHourlyJson);

      expect(hourly.temperature, greaterThan(0));
      expect(hourly.temperature, lessThan(50));
      expect(hourly.icon, isNotEmpty);
    });
  });

  group('DateFormatter Tests', () {
    test('Format full date correctly', () {
      final dt = DateTime(2026, 4, 25);
      final formatted = DateFormatter.formatFull(dt);

      expect(formatted, isNotEmpty);
      expect(formatted, contains('2026'));
    });

    test('Format weekday correctly', () {
      final dt = DateTime(2026, 4, 25); // Saturday
      final formatted = DateFormatter.formatWeekday(dt);

      expect(formatted, isNotEmpty);
    });

    test('Format day and month correctly', () {
      final dt = DateTime(2026, 4, 25);
      final formatted = DateFormatter.formatDayMonth(dt);

      expect(formatted, '25/04');
    });

    test('Format time 24 hour correctly', () {
      final dt = DateTime(2026, 4, 25, 14, 30);
      final formatted = DateFormatter.formatTime(dt, is24Hour: true);

      expect(formatted, '14:30');
    });

    test('Format hour 24 hour correctly', () {
      final dt = DateTime(2026, 4, 25, 14, 30);
      final formatted = DateFormatter.formatHour(dt, is24Hour: true);

      expect(formatted, '14:30');
    });

    test('Format Unix timestamp correctly', () {
      final unix = 1619104800; // Thu Apr 22 2021 16:00:00 GMT
      final formatted = DateFormatter.fromUnix(unix, is24Hour: true);

      expect(formatted, isNotEmpty);
      expect(formatted, contains(':'));
    });
  });

  group('WeatherIcons Tests', () {
    test('Get icon for clear weather', () {
      final icon = WeatherIcons.getIcon('clear');
      expect(icon, isNotNull);
    });

    test('Get icon for clouds', () {
      final icon = WeatherIcons.getIcon('clouds');
      expect(icon, isNotNull);
    });

    test('Get icon for rain', () {
      final icon = WeatherIcons.getIcon('rain');
      expect(icon, isNotNull);
    });

    test('Get icon for thunderstorm', () {
      final icon = WeatherIcons.getIcon('thunderstorm');
      expect(icon, isNotNull);
    });

    test('Get icon for snow', () {
      final icon = WeatherIcons.getIcon('snow');
      expect(icon, isNotNull);
    });

    test('Get icon for fog', () {
      final icon = WeatherIcons.getIcon('fog');
      expect(icon, isNotNull);
    });

    test('Get default icon for unknown condition', () {
      final icon = WeatherIcons.getIcon('unknown_condition');
      expect(icon, isNotNull);
    });

    test('Get gradient for clear weather', () {
      final gradient = WeatherIcons.getGradient('clear');
      expect(gradient, hasLength(2));
    });

    test('Get gradient for rain', () {
      final gradient = WeatherIcons.getGradient('rain');
      expect(gradient, hasLength(2));
    });

    test('Get wind direction from degrees - North', () {
      final dir = WeatherIcons.windDirection(0);
      expect(dir, 'Bắc');
    });

    test('Get wind direction from degrees - East', () {
      final dir = WeatherIcons.windDirection(90);
      expect(dir, 'Đông');
    });

    test('Get wind direction from degrees - South', () {
      final dir = WeatherIcons.windDirection(180);
      expect(dir, 'Nam');
    });

    test('Get wind direction from degrees - West', () {
      final dir = WeatherIcons.windDirection(270);
      expect(dir, 'Tây');
    });

    test('Get wind direction from degrees - Northeast', () {
      final dir = WeatherIcons.windDirection(45);
      expect(dir, 'Đông Bắc');
    });
  });

  group('Model Equality Tests', () {
    test('Two identical WeatherModels have same properties', () {
      final weather1 = WeatherModel.fromJson(sampleWeatherJson);
      final weather2 = WeatherModel.fromJson(sampleWeatherJson);

      expect(weather1.cityName, weather2.cityName);
      expect(weather1.temperature, weather2.temperature);
      expect(weather1.country, weather2.country);
    });

    test('Two identical ForecastModels have same properties', () {
      final forecast1 = ForecastModel.fromJson(sampleForecastJson);
      final forecast2 = ForecastModel.fromJson(sampleForecastJson);

      expect(forecast1.temperature, forecast2.temperature);
      expect(forecast1.mainCondition, forecast2.mainCondition);
      expect(forecast1.pop, forecast2.pop);
    });
  });

  group('Data Validation Tests', () {
    test('WeatherModel validates temperature range', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);

      // Typical weather temperature range
      expect(weather.temperature, greaterThan(-50));
      expect(weather.temperature, lessThan(60));
    });

    test('ForecastModel validates humidity range', () {
      final forecast = ForecastModel.fromJson(sampleForecastJson);

      expect(forecast.humidity, greaterThanOrEqualTo(0));
      expect(forecast.humidity, lessThanOrEqualTo(100));
    });

    test('WeatherModel validates wind speed', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);

      expect(weather.windSpeed, greaterThanOrEqualTo(0));
    });

    test('WeatherModel validates wind direction', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);

      expect(weather.windDeg, greaterThanOrEqualTo(0));
      expect(weather.windDeg, lessThanOrEqualTo(360));
    });

    test('ForecastModel validates rain probability', () {
      final forecast = ForecastModel.fromJson(sampleForecastJson);

      expect(forecast.pop, greaterThanOrEqualTo(0));
      expect(forecast.pop, lessThanOrEqualTo(1));
    });
  });

  group('DateTime Parsing Tests', () {
    test('Parse Unix timestamp correctly', () {
      final unix = 1619104800;
      final dt = DateTime.fromMillisecondsSinceEpoch(unix * 1000);

      expect(dt.isUtc, false);
      expect(dt.year, 2021);
    });

    test('WeatherModel dateTime is parsed correctly', () {
      final weather = WeatherModel.fromJson(sampleWeatherJson);

      expect(weather.dateTime, isNotNull);
      expect(weather.dateTime, isA<DateTime>());
    });

    test('ForecastModel dateTime is parsed correctly', () {
      final forecast = ForecastModel.fromJson(sampleForecastJson);

      expect(forecast.dateTime, isNotNull);
      expect(forecast.dateTime, isA<DateTime>());
    });
  });
}
