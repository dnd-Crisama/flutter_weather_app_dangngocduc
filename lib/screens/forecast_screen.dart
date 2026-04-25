import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/daily_forecast_card.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final daily = provider.dailyForecast;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dự báo 5 ngày - ${provider.currentWeather?.cityName ?? ''}',
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: daily.isEmpty
          ? const Center(child: Text('Không có dữ liệu dự báo'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: daily.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return DailyForecastCard(
                  forecast: daily[index],
                  provider: provider,
                );
              },
            ),
    );
  }
}
