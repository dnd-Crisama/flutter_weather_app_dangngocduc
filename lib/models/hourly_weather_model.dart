// Model hien thi du bao theo gio
class HourlyWeatherModel {
  final DateTime dateTime;
  final double temperature;
  final String icon;
  final String description;
  final double pop; // xac suat mua

  HourlyWeatherModel({
    required this.dateTime,
    required this.temperature,
    required this.icon,
    required this.description,
    required this.pop,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num).toDouble(),
      icon: json['weather'][0]['icon'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
