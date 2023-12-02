
import '../model/city_weather_model.dart';
import '../model/hourly_weather_model.dart';
import '../model/weather_model.dart';

sealed class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  HourlyWeatherModel? hourlyWeatherModel;
  WeatherModel? weatherModel;
  CityWeatherModel? cityWeatherModel;

  WeatherLoadSuccess(
    this.weatherModel,
    this.hourlyWeatherModel,
    this.cityWeatherModel,
  );
}

class WeatherFailure extends WeatherState {}
