import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_detail_item.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';
import '../utils/weather_icons.dart';
import '../utils/date_formatter.dart';
import 'search_screen.dart';
import 'forecast_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.state == WeatherState.loading) {
            return const LoadingShimmer();
          }

          if (provider.state == WeatherState.error) {
            return ErrorWidgetCustom(
              message: provider.errorMessage,
              onRetry: () => provider.fetchByLocation(),
              onSearch: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
            );
          }

          if (provider.currentWeather == null) {
            return const Center(
              child: Text('Nhấn nut GPS để lấy thời tiết hiện tại'),
            );
          }

          final weather = provider.currentWeather!;

          return RefreshIndicator(
            onRefresh: () => provider.refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CurrentWeatherCard(weather: weather, provider: provider),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.my_location,
                                  color: Colors.white,
                                ),
                                onPressed: () => provider.fetchByLocation(),
                                tooltip: 'Vị trí hiện tại',
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SearchScreen(),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      provider.isFavorite(weather.cityName)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      provider.toggleFavorite(weather.cityName);
                                      final msg =
                                          provider.isFavorite(weather.cityName)
                                          ? 'Đã thêm vào yêu thích'
                                          : 'Đã xóa khỏi yêu thích';
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(msg),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SettingsScreen(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chi tiết thời tiết',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherDetailItem(
                                      icon: Icons.water_drop,
                                      label: 'Độ ẩm',
                                      value: '${weather.humidity}%',
                                      color: Colors.blue,
                                    ),
                                    WeatherDetailItem(
                                      icon: Icons.air,
                                      label: 'Tốc độ gió',
                                      value: provider.convertWind(
                                        weather.windSpeed,
                                      ),
                                      color: Colors.teal,
                                    ),
                                    WeatherDetailItem(
                                      icon: Icons.explore,
                                      label: 'Hướng gió',
                                      value: WeatherIcons.windDirection(
                                        weather.windDeg,
                                      ),
                                      color: Colors.green,
                                    ),
                                    WeatherDetailItem(
                                      icon: Icons.compress,
                                      label: 'Áp suất',
                                      value: '${weather.pressure} hPa',
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherDetailItem(
                                      icon: Icons.visibility,
                                      label: 'Tầm nhìn',
                                      value:
                                          '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                                      color: Colors.purple,
                                    ),
                                    WeatherDetailItem(
                                      icon: Icons.cloud,
                                      label: 'Mây mù',
                                      value: '${weather.cloudiness}%',
                                      color: Colors.blueGrey,
                                    ),
                                    WeatherDetailItem(
                                      icon: Icons.wb_twilight,
                                      label: 'Bình minh',
                                      value: DateFormatter.fromUnix(
                                        weather.sunrise,
                                        is24Hour: provider.is24Hour,
                                      ),
                                      color: Colors.amber,
                                    ),
                                    WeatherDetailItem(
                                      icon: Icons.nightlight_round,
                                      label: 'Hoàn hôn',
                                      value: DateFormatter.fromUnix(
                                        weather.sunset,
                                        is24Hour: provider.is24Hour,
                                      ),
                                      color: Colors.deepOrange,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        if (provider.hourlyForecast.isNotEmpty) ...[
                          const Text(
                            'Dự báo 24 giờ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (provider.hourlyForecast.isNotEmpty)
                            HourlyForecastList(
                              hourlyList: provider.hourlyForecast,
                              provider: provider,
                            ),
                          const SizedBox(height: 20),
                        ],

                        if (provider.dailyForecast.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Dự báo 5 ngày',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ForecastScreen(),
                                  ),
                                ),
                                child: const Text('Xem tất cả'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: provider.dailyForecast
                                  .take(5)
                                  .map(
                                    (f) => DailyForecastCard(
                                      forecast: f,
                                      provider: provider,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
