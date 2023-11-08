import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/home_page1.dart';
import 'package:weather_app/pages/notification_page.dart';
import 'package:weather_app/pages/person_page.dart';
import 'package:weather_app/pages/search_page.dart';

import '../utils/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List pages = [
    HomePage1(),
    SearchPage(),
    PersonPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        pages[currentIndex],
        Align(
          alignment: Alignment.bottomCenter,
          child: CrystalNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: AppColors.containerColor2,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            indicatorColor: AppColors.forecastsColor,
            items: [
              CrystalNavigationBarItem(

                unselectedColor: Colors.white,
                selectedColor: AppColors.forecastsColor,
                icon: Icons.home_sharp,
              ),
              CrystalNavigationBarItem(
                unselectedColor: Colors.white,
                selectedColor: AppColors.forecastsColor,
                icon: Icons.search,
              ),
              CrystalNavigationBarItem(
                unselectedColor: Colors.white,
                selectedColor: AppColors.forecastsColor,
                icon: Icons.person,
              ),
              CrystalNavigationBarItem(
                unselectedColor: Colors.white,
                selectedColor: AppColors.forecastsColor,
                icon: Icons.info_outline,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
