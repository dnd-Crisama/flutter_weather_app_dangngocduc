import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'providers/weather_provider.dart';
import 'providers/location_provider.dart';
import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';
import 'services/connectivity_service.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load bien moi truong tu .env
  await dotenv.load(fileName: '.env');

  // Initialize locale data for date formatting
  await initializeDateFormatting('vi');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // LocationProvider: quan ly quyen va vi tri GPS
        ChangeNotifierProvider(
          create: (_) => LocationProvider(locationService: LocationService()),
        ),
        // WeatherProvider: quan ly toan bo state thoi tiet
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            weatherService: WeatherService(),
            locationService: LocationService(),
            storageService: StorageService(),
            connectivityService: ConnectivityService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
