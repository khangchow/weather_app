// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:weather_app/models/hourly_forecast.dart';

class Weather {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currentWindSpeed;
  final int currentHumidity;
  final List<HourlyForecast> hourlyForecasts;

  Weather(
      {required this.currentTemp,
      required this.currentSky,
      required this.currentPressure,
      required this.currentWindSpeed,
      required this.currentHumidity,
      required this.hourlyForecasts});

  Weather copyWith(
      {double? currentTemp,
      String? currentSky,
      int? currentPressure,
      double? currentWindSpeed,
      int? currentHumidity,
      List<HourlyForecast>? hourlyForecasts}) {
    return Weather(
        currentTemp: currentTemp ?? this.currentTemp,
        currentSky: currentSky ?? this.currentSky,
        currentPressure: currentPressure ?? this.currentPressure,
        currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
        currentHumidity: currentHumidity ?? this.currentHumidity,
        hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecasts': hourlyForecasts
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final List<HourlyForecast> hourlyForecasts = [];
    for (var i = 1; i <= 5; i++) {
      final hourlyForecast = map['list'][i];
      hourlyForecasts.add(
        HourlyForecast(
          sky: hourlyForecast['weather'][0]['main'],
          temp: hourlyForecast['main']['temp'].toString(),
          time: DateFormat.j().format(
            DateTime.parse(hourlyForecast['dt_txt']),
          ),
        ),
      );
    }
    return Weather(
        currentTemp: currentWeatherData['main']['temp'],
        currentSky: currentWeatherData['weather'][0]['main'],
        currentPressure: currentWeatherData['main']['pressure'],
        currentWindSpeed: currentWeatherData['wind']['speed'],
        currentHumidity: currentWeatherData['main']['humidity'],
        hourlyForecasts: hourlyForecasts);
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Weather(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, hourlyForcasts: $hourlyForecasts)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.hourlyForecasts == hourlyForecasts;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        hourlyForecasts.hashCode;
  }
}
