import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../model/city_weather_model.dart';
import '../model/hourly_weather_model.dart';
import '../model/weather_model.dart';

class NetworkService {
  static final NetworkService networkService = NetworkService._internal();

  factory NetworkService() {
    return networkService;
  }

  NetworkService._internal();

  final Dio _dio = Dio();
  static const String _apiKey = 'c94f344635776bfe376d33596b4b8ed1';

  Future<CityWeatherModel> getCityWeather(String city) async {
    final cityWeather = (await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${_apiKey}&units=metric'));
    CityWeatherModel cityWeatherModel =
        CityWeatherModel.fromJson(cityWeather.data);
    return cityWeatherModel;
  }

  Future<WeatherModel> getWeather(double lat, double lon) async {
    final currentWeather = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=$_apiKey&units=metric');

    WeatherModel weatherModel = WeatherModel.fromJson(currentWeather.data);

    return weatherModel;
  }

  Future<HourlyWeatherModel> getHourlyWeather(double lat, double lon) async {
    final hourlyWeatherResponse = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=$_apiKey&units=metric');
    HourlyWeatherModel hourlyWeatherModel =
        HourlyWeatherModel.fromJson(hourlyWeatherResponse.data);

    return hourlyWeatherModel;
  }

  Future getCurrentIcon(String icon) async {
    var iconResponse =
        _dio.get('https://openweathermap.org/img/wn/${icon}@2x.png');
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
