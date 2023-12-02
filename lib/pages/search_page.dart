import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/city_weather_model.dart';
import 'package:weather_app/services/city_weather_service.dart';
import 'package:weather_app/utils/utils.dart';

import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../utils/app_colors.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  CityWeatherService cityWeatherService = CityWeatherService();
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      bloc: context.read<WeatherCubit>(),
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AppPng.bgSplash,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.gradientColor1,
                      AppColors.gradientColor2,
                      AppColors.gradientColor3,
                    ],
                  ),
                ),
              ),
              buildSingleChildScrollView(context, state)
            ],
          ),
        );
      },
    );
  }

  buildSingleChildScrollView(
    BuildContext context,
    WeatherState state,
  ) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 52, bottom: 54),
            child: Center(
              child: Text(
                'Search for City',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(colors: [
                          AppColors.containerColor1,
                          AppColors.containerColor2,
                        ])),
                    child: TextField(
                      onChanged: (value) {
                        cityName = value;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'Search City',
                        prefixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<WeatherCubit>()
                                .getWeather(cityName ?? 'Tashkent');
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.center,
                            colors: [
                              AppColors.containerColor1,
                              AppColors.containerColor2,
                            ]),
                      ),
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<WeatherCubit>()
                              .getWeather(cityName ?? 'Tashkent');
                        },
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      )),
                ),
              ],
            ),
          ),
          cityName == null ? SizedBox() : buildPadding(context,state,cityName?? '')
        ],
      ),
    );
    }
  }

   buildPadding(BuildContext context,WeatherState state,String cityName) {
    switch(state){

      case WeatherInitial():
        return('');
      case WeatherLoadInProgress():
        return Center(child: CircularProgressIndicator(),);
      case WeatherLoadSuccess():
        {
          var data=(state as WeatherLoadSuccess).cityWeatherModel;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Container(
              height: MediaQuery.of(context).size.height / 9 * 6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.center,
                    colors: [
                      AppColors.containerColor1,
                      AppColors.containerColor2,
                    ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${cityName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${data?.weather![0].description}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Image.network(
                        'https://openweathermap.org/img/wn/${data!.weather![0].icon}@2x.png',
                        height: 180,
                        width: 180,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildWeatherContainer(
                        text: '30%',
                        text1: 'Precipitation',
                        image: AppPng.umbrellaPng,
                      ),
                      buildWeatherContainer(
                        text: data.main!.humidity.toString(),
                        text1: 'Humidity',
                        image: AppPng.waterPng,
                      ),
                      buildWeatherContainer(
                        text: '${data.wind!.speed.toInt()}km/h',
                        text1: 'Wind Speed',
                        image: AppPng.windPng,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Temp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${data.main!.temp.toInt()}°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Temp feels like',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${data.main!.feelsLike.toInt()}°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Temp max',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${data.main!.tempMax.toInt()}°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Temp min',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${data.main!.tempMin.toInt()}°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      case WeatherFailure():
        return Text('Error');
    }
  }


class buildWeatherContainer extends StatelessWidget {
  buildWeatherContainer({
    super.key,
    required this.text,
    required this.text1,
    required this.image,
  });

  String text;
  String text1;
  String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(image),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          text1,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
