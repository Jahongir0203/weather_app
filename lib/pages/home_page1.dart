import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/model/city_weather_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/pages/cities.dart';
import 'package:weather_app/services/city_weather_service.dart';
import 'package:weather_app/services/current_weather.dart';
import 'package:weather_app/services/hourly_weather_service.dart';
import 'package:weather_app/services/loction.dart';

import '../model/hourly_weather_model.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';

class HomePage1 extends StatefulWidget {
  HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

enum Status {
  loading,
  loaded,
  error,
}

class _HomePage1State extends State<HomePage1> {
  List<String> cities = [
    'London',
    'Moscow',
    'New York',
    'Madinah',
    "Andijan",
    "Bukhara",
    "Fergana",
    "Jizzakh",
    "Namangan",
    "Navoi",
    "Samarkand",
    "Tashkent",
    "Nukus"
  ];

  LocationService locationService = LocationService();
  Status status = Status.loading;
  CurrentWeatherService currentWeatherService = CurrentWeatherService();
  HourlyWeatherService hourlyWeatherService = HourlyWeatherService();
  CityWeatherService cityWeatherService = CityWeatherService();

  late HourlyWeatherModel hourlyWeatherModel;
  late WeatherModel weatherModel;
  late CityWeatherModel cityWeatherModel;

  @override
  void initState() {
    locationService.determinePosition().then((value) => {
          if (value != null)
            {
              currentWeatherService
                  .getWeather(value.latitude, value.longitude)
                  .then((value) => {
                        weatherModel = value,
                      })
                  .onError((error, stackTrace) => {}),
              hourlyWeatherService
                  .getHourlyWeather(value.latitude, value.longitude)
                  .then((value) => {
                        setState(() {
                          status = Status.loaded;
                        }),
                        hourlyWeatherModel = value,
                      })
                  .onError((error, stackTrace) => {
                        print(error),
                        setState(() {
                          status = Status.error;
                        }),
                      }),
            }
        });
    super.initState();
  }

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
          buildBody(),
        ],
      ),
    );
  }

  buildBody() {
    switch (status) {
      case Status.loading:
        return Shimmer(gradient: LinearGradient(colors: [
          AppColors.containerColor1,
          AppColors.containerColor2,

        ]), child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 15,
                  left: 15,
                  bottom: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.center,
                            colors: [
                              AppColors.containerColor1,
                              AppColors.containerColor2,
                            ],
                          )),
                    ),

                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.center,
                            colors: [
                              AppColors.containerColor1,
                              AppColors.containerColor2,
                            ],
                          )),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30,right: 120,left: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Container(
                  height:305,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.center,
                          colors: [
                            AppColors.containerColor1,
                            AppColors.containerColor2,
                          ])),
                ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 70, right: 54, top: 19, bottom: 30),
                child: Container(
                  height: 95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.center,
                          colors: [
                            AppColors.containerColor1,
                            AppColors.containerColor2,
                          ])),
                ),
              ),
              SizedBox(
                height:230,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5),
                                  child: Container(
                                    height:160,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                            begin: Alignment.center,
                                            end: Alignment.center,
                                            colors: [
                                              AppColors.containerColor1,
                                              AppColors.containerColor2,
                                            ])),
                                  ),
                                );
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5),
                                  child: Container(
                                    height: 50,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                            begin: Alignment.center,
                                            end: Alignment.center,
                                            colors: [
                                              AppColors.containerColor1,
                                              AppColors.containerColor2,
                                            ])),
                                  ),
                                );
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ));
      case Status.loaded:
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 15,
                  left: 15,
                  bottom: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.center,
                            colors: [
                              AppColors.containerColor1,
                              AppColors.containerColor2,
                            ],
                          )),
                      child: Image.asset(AppPng.leading1),
                    ),
                    const Text(
                      'Weather App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.center,
                              colors: [
                                AppColors.containerColor1,
                                AppColors.containerColor2,
                              ],
                            )),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.replay,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      weatherModel.weather![0].description.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.wordsColor,
                      ),
                    ),
                    Image.network(
                      'https://openweathermap.org/img/wn/${weatherModel.weather![0].icon}@2x.png',
                      fit: BoxFit.fill,
                      height: 130,
                      width: 130,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Text(
                        weatherModel.main!.temp!.toInt().toString() + '°',
                        style: const TextStyle(
                          fontSize: 81,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        DateTime.now()
                            .add(Duration(
                                seconds: weatherModel.timezone! -
                                    DateTime.now().timeZoneOffset.inMinutes))
                            .toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.wordsColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 70, right: 54, top: 19, bottom: 30),
                child: Container(
                  height: 95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.center,
                          colors: [
                            AppColors.containerColor1,
                            AppColors.containerColor2,
                          ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildWeatherContainer(
                        text: '30%',
                        text1: 'Precipitation',
                        image: AppPng.umbrellaPng,
                      ),
                      buildWeatherContainer(
                        text: '${weatherModel.main!.humidity}%',
                        text1: 'Humidity',
                        image: AppPng.waterPng,
                      ),
                      buildWeatherContainer(
                        text: '${weatherModel.wind!.speed}km/h',
                        text1: 'Wind Speed',
                        image: AppPng.windPng,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 230,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                color: AppColors.wordsColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '5-days Forecasts',
                              style: TextStyle(
                                color: AppColors.wordsColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: hourlyWeatherModel.list!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.center,
                                    colors: [
                                      AppColors.containerColor1,
                                      AppColors.containerColor2,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        hourlyWeatherModel.list![index].dtTxt
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: AppColors.wordsColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        'https://openweathermap.org/img/wn/${hourlyWeatherModel.list![index].weather![0].icon}@2x.png',
                                      ),
                                      Text(
                                        '${hourlyWeatherModel.list![index].main!.temp.toInt()}°',
                                        style: const TextStyle(
                                          color: AppColors.wordsColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Other Citiies',
                              style: TextStyle(
                                color: AppColors.wordsColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: AppColors.wordsColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cities.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: cityWeatherService
                                    .getCityWeather(cities[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text('');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error');
                                    }

                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          onLongPress: (){
                                             Navigator.push(context,MaterialPageRoute(builder: (context)=>CitiesDataPage(cityname: cities[index])));

                                          },
                                          child: Container(
                                            height: 50,
                                            width: 160,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.center,
                                                    end: Alignment.center,
                                                    colors: [
                                                      AppColors.containerColor1,
                                                      AppColors.containerColor2,
                                                    ])),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.network(
                                                    'https://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon}@2x.png'),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      cities[index],
                                                      style: const TextStyle(
                                                        color:
                                                            AppColors.wordsColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!.weather![0].main
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .wordsColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${snapshot.data!.main!.temp.toInt()}°',
                                                  style: const TextStyle(
                                                    color: AppColors.wordsColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  return Container();
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        );

      case Status.error:
        return const Center(child: Text('Error',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),));
    }
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
