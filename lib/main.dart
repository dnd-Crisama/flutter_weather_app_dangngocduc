import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'providers/weather_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/location_provider.dart';
import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';
import 'services/connectivity_service.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await initializeDateFormatting('vi');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(locationService: LocationService()),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            weatherService: WeatherService(),
            locationService: LocationService(),
            storageService: StorageService(),
            connectivityService: ConnectivityService(),
          ),
        ),
      ],
      child: Consumer2<ThemeProvider, WeatherProvider>(
        builder: (context, themeProvider, weatherProvider, child) {
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.getLightTheme(),
            darkTheme: ThemeProvider.getDarkTheme(),
            themeMode: weatherProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
