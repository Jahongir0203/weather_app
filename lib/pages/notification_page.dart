import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppPng.bgSplash,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:const BoxDecoration(
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
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 30,),
              child: Column(
                children: [
                  Text(('''
    This Weather App illustrates weather information's. When you log in this app firstly, you can see Splash page. then, in home page app send permission in to your app and detect your location and get weather information about your location.
    If you  want to know about weather information's next 5 days please watch bottom. in the bottom you can get information's about weather.
    At the end of bottom app illustrates most famous cities weather forecasts. If you tap bottom long it illustares more information about this city weather.
    In Search page you can search city by name in English, you can see weather information's.If you want connect with ne please go Person page
                  '''),style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
