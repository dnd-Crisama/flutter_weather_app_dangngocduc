import 'package:flutter/material.dart';
import '../models/hourly_weather_model.dart';
import '../providers/weather_provider.dart';
import '../utils/date_formatter.dart';
import '../utils/weather_icons.dart';

class HourlyForecastList extends StatelessWidget {
  final List<HourlyWeatherModel> hourlyList;
  final WeatherProvider provider;

  const HourlyForecastList({
    super.key,
    required this.hourlyList,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: hourlyList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = hourlyList[index];
          return Container(
            width: 72,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.25)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Gio
                Text(
                  DateFormatter.formatHour(
                    item.dateTime,
                    is24Hour: provider.is24Hour,
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Icon
                Icon(
                  WeatherIcons.getIcon(item.description),
                  size: 28,
                  color: Colors.blue.shade700,
                ),
                // Nhiet do
                Text(
                  '${provider.convertTemp(item.temperature).round()}°${provider.tempUnit}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Xac suat mua
                if (item.pop > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 10,
                        color: Colors.blue,
                      ),
                      Text(
                        '${(item.pop * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
