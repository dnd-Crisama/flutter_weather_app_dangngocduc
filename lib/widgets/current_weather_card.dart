import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../utils/weather_icons.dart';
import '../utils/date_formatter.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final WeatherProvider provider;

  const CurrentWeatherCard({
    super.key,
    required this.weather,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isNight = WeatherIcons.isNightTime(
      sunrise: weather.sunrise,
      sunset: weather.sunset,
      currentTime: weather.dateTime,
    );
    final gradient = WeatherIcons.getGradient(
      weather.mainCondition,
      isNight: isNight,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          child: Column(
            children: [
              if (provider.isShowingCache)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.history, size: 14, color: Colors.orange),
                      const SizedBox(width: 6),
                      Text(
                        provider.lastUpdateTime != null
                            ? 'Dữ liệu cũ - ${DateFormat('HH:mm dd/MM').format(provider.lastUpdateTime!)}'
                            : 'Dữ liệu cũ - mất kết nối mạng',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

              Text(
                '${weather.cityName}, ${weather.country}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                DateFormatter.formatFull(weather.dateTime),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 12),

              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    WeatherIcons.getIcon(
                      weather.mainCondition,
                      isNight: isNight,
                    ),
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),

              Text(
                '${provider.convertTemp(weather.temperature).round()}°${provider.tempUnit}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 78,
                  fontWeight: FontWeight.w200,
                ),
              ),

              Text(
                weather.description.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Cảm giác như: ${provider.convertTemp(weather.feelsLike).round()}°${provider.tempUnit}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Min: ${provider.convertTemp(weather.tempMin).round()}°',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'Max: ${provider.convertTemp(weather.tempMax).round()}°',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
