import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/home_page1.dart';
import 'package:weather_app/pages/main_page.dart';
import 'package:weather_app/utils/app_colors.dart';
import 'package:weather_app/utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  @override
  void initState() {

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>MainPage()));
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
            fit: BoxFit.fill,
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
              Expanded(
                child: Image.asset(
                  AppPng.weatherPng,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                  const  Text(
                      "WEATHER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  const  Text(
                      "ForeCasts",
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w600,
                        color: AppColors.forecastsColor,
                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.only(top: 100),
                       child: Align(
                         alignment: Alignment.bottomCenter,
                         child: LoadingAnimationWidget.staggeredDotsWave(
                           color: Colors.white,
                           size: 50,
                         ),
                       ),
                     )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
