
import 'package:dio/dio.dart';
import 'package:weather_app/model/city_weather_model.dart';

class CityWeatherService{
  final dio=Dio();
  static const String _apiKey='c94f344635776bfe376d33596b4b8ed1';

  Future<CityWeatherModel> getCityWeather(String city)async {
    final cityWeather=(await dio.get('https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${_apiKey}&units=metric'));
    CityWeatherModel cityWeatherModel=CityWeatherModel.fromJson(cityWeather.data);
    return cityWeatherModel;

  }


}