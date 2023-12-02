import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/cubit/weather_state.dart';

import '../model/city_weather_model.dart';
import '../model/hourly_weather_model.dart';
import '../model/weather_model.dart';
import '../services/network_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  NetworkService networkService = NetworkService();

  getWeather(String city) async {
    emit(WeatherLoadInProgress());
    Position position = await networkService.determinePosition();

    WeatherModel weatherModel =
        await networkService.getWeather(position.latitude, position.longitude);

    HourlyWeatherModel hourlyWeatherModel = await networkService
        .getHourlyWeather(position.latitude, position.longitude);

    CityWeatherModel cityWeatherModel=await networkService.getCityWeather(city);

    if (weatherModel != null) {
      emit(WeatherLoadSuccess(weatherModel,hourlyWeatherModel,cityWeatherModel));
    } else {
      emit(WeatherFailure());
    }
  }
}
