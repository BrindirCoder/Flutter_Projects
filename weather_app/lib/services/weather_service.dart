import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // کلیلەکەی خۆت لێرە دابنێ
  static const String apiKey =
      'YOUR_API_KEY_HERE'; // get your api from https://openweathermap.org/ website
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel?> fetchWeather(String cityName) async {
    final url = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
