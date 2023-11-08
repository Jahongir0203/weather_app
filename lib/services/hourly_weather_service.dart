
import 'package:dio/dio.dart';
import 'package:weather_app/model/hourly_weather_model.dart';

import 'location_service.dart';

class HourlyWeatherService{
  static const String _appKey='c94f344635776bfe376d33596b4b8ed1';
  final dio=Dio();
  
  Future<HourlyWeatherModel> getHourlyWeather( double lat, double lon) async {

    final hourlyWeatherResponse= await dio.get('https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=$_appKey&units=metric');
     HourlyWeatherModel hourlyWeatherModel=HourlyWeatherModel.fromJson(hourlyWeatherResponse.data);
     print(hourlyWeatherModel);

     return hourlyWeatherModel;

  }

}