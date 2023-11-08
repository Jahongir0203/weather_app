import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../model/weather_model.dart';
import 'location_service.dart';

class CurrentWeatherService {


  static const String _apiKey = 'c94f344635776bfe376d33596b4b8ed1';
  final dio = Dio();


  Future<WeatherModel> getWeather( double lat, double lon) async {

    final currentWeather = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=$_apiKey&units=metric');

    WeatherModel weatherModel = WeatherModel.fromJson(currentWeather.data);

    return weatherModel;
  }
}
