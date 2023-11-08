import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/city_weather_service.dart';

import '../model/city_weather_model.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';
import 'home_page1.dart';

class CitiesDataPage extends StatefulWidget {
  CitiesDataPage({Key? key, required this.cityname}) : super(key: key);
  String cityname;

  @override
  State<CitiesDataPage> createState() => _CitiesDataPageState();
}

class _CitiesDataPageState extends State<CitiesDataPage>
    with TickerProviderStateMixin {
  CityWeatherService cityWeatherService = CityWeatherService();

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 52, bottom: 54),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size:22,
                            ),),
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(
                          widget.cityname.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
                  child: FutureBuilder(
                    future: cityWeatherService.getCityWeather(widget.cityname!),
                    builder: (BuildContext context,
                        AsyncSnapshot<CityWeatherModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SpinKitDoubleBounce(
                          color: Colors.white,
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error');
                        }
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        widget.cityname.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.weather![0].description
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon}@2x.png',
                                    height: 180,
                                    width: 180,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildWeatherContainer(
                                    text: '30%',
                                    text1: 'Precipitation',
                                    image: AppPng.umbrellaPng,
                                  ),
                                  buildWeatherContainer(
                                    text: snapshot.data!.main!.humidity
                                        .toString(),
                                    text1: 'Humidity',
                                    image: AppPng.waterPng,
                                  ),
                                  buildWeatherContainer(
                                    text:
                                        '${snapshot.data!.wind!.speed.toInt()}km/h',
                                    text1: 'Wind Speed',
                                    image: AppPng.windPng,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    '${snapshot.data!.main!.temp.toInt()}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    '${snapshot.data!.main!.feelsLike.toInt()}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    '${snapshot.data!.main!.tempMax.toInt()}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    '${snapshot.data!.main!.tempMin.toInt()}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                      }

                      return SpinKitSquareCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 1200)),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
