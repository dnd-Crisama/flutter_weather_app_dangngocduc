import 'package:flutter/material.dart';
import '../models/forecast_model.dart';
import '../providers/weather_provider.dart';
import '../utils/date_formatter.dart';
import '../utils/weather_icons.dart';

class DailyForecastCard extends StatelessWidget {
  final ForecastModel forecast;
  final WeatherProvider provider;

  const DailyForecastCard({
    super.key,
    required this.forecast,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday =
        forecast.dateTime.day == now.day &&
        forecast.dateTime.month == now.month;
    final isNight = false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isToday
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isToday
                      ? 'Hôm nay'
                      : DateFormatter.formatWeekday(forecast.dateTime),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isToday
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
                Text(
                  DateFormatter.formatDayMonth(forecast.dateTime),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          Icon(
            WeatherIcons.getIcon(forecast.mainCondition, isNight: isNight),
            size: 36,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecast.description,
                  style: const TextStyle(fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (forecast.pop > 0)
                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 12,
                        color: Colors.blue,
                      ),
                      Text(
                        ' ${(forecast.pop * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${provider.convertTemp(forecast.tempMax).round()}°',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${provider.convertTemp(forecast.tempMin).round()}°',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
