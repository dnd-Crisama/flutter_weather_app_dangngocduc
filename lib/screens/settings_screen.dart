import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // === Don vi ===
              _sectionHeader('ĐƠN VỊ'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Don vi nhiet do
                    SwitchListTile(
                      secondary: const Icon(Icons.thermostat),
                      title: const Text('Đơn vị nhiệt độ'),
                      subtitle: Text(
                        provider.isCelsius ? 'Celsius (C)' : 'Fahrenheit (F)',
                      ),
                      value: provider.isCelsius,
                      onChanged: (_) => provider.toggleTempUnit(),
                    ),
                    const Divider(height: 1),

                    // Don vi toc do gio
                    ListTile(
                      leading: const Icon(Icons.air),
                      title: const Text('Đơn vị tốc độ gió'),
                      subtitle: Text(_windUnitLabel(provider.windUnit)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showWindUnitPicker(context, provider),
                    ),
                    const Divider(height: 1),

                    // Dinh dang gio
                    SwitchListTile(
                      secondary: const Icon(Icons.access_time),
                      title: const Text('Định dạng 24 giờ'),
                      subtitle: Text(
                        provider.is24Hour
                            ? 'Giờ 24h (14:30)'
                            : 'Giờ 12h (2:30 PM)',
                      ),
                      value: provider.is24Hour,
                      onChanged: (_) => provider.toggleTimeFormat(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // === Thanh pho yeu thich ===
              _sectionHeader('THÀNH PHỐ YÊU THÍCH (tối đa 5)'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: provider.favorites.isEmpty
                    ? const ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Chưa có thành phố yêu thích'),
                        subtitle: Text(
                          'Vào màn hình chính -> nhấn biểu tượng trái tim',
                        ),
                      )
                    : Column(
                        children: provider.favorites.map((city) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.location_city),
                                title: Text(city),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      provider.toggleFavorite(city),
                                ),
                              ),
                              if (city != provider.favorites.last)
                                const Divider(height: 1),
                            ],
                          );
                        }).toList(),
                      ),
              ),

              const SizedBox(height: 20),

              // === Ve ung dung ===
              _sectionHeader('VỀ ỨNG DỤNG'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.cloud_outlined),
                      title: Text('Nguồn dữ liệu'),
                      trailing: Text(
                        'OpenWeatherMap',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.update),
                      title: Text('Cache hợp lệ'),
                      trailing: Text(
                        '30 phút',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.code),
                      title: Text('Phiên bản'),
                      trailing: Text(
                        '1.0.0',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1,
        ),
      ),
    );
  }

  String _windUnitLabel(String unit) {
    switch (unit) {
      case AppConstants.windKmh:
        return 'Km/h';
      case AppConstants.windMph:
        return 'Mph';
      default:
        return 'm/s';
    }
  }

  // Dialog chon don vi gio
  void _showWindUnitPicker(BuildContext context, WeatherProvider provider) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chọn đơn vị tốc độ gió'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                AppConstants.windMs,
                AppConstants.windKmh,
                AppConstants.windMph,
              ].map((unit) {
                return RadioListTile<String>(
                  title: Text(_windUnitLabel(unit)),
                  value: unit,
                  groupValue: provider.windUnit,
                  onChanged: (val) {
                    if (val != null) provider.setWindUnit(val);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
