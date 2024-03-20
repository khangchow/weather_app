import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<Weather> getCurrentWeather(String cityName) async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(weatherData);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return Weather.fromJson(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
