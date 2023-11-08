import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_colors.dart';
import 'package:weather_app/utils/utils.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 40),
              child: Column(
                children: [
                  Text('''
   Hi!.I am Jahongir Eshonqulov who develops this app. I was born in 18 November in 2003 in Bukhara.I was studied at International maths school in Karakul. Nowadays i am studying at TSUE(Tashkent State Univertisity of Economics) in 3rd course.I am good at maths and i had B2 certificate from IELTS.I am interested in learning new knowledge's in my field.And i am learning Flutter development.
  
  Telegram:https://t.me/Jahongir_1811
  GitHub:https://github.com/Jahongir0203
  Instagram:jahongireshonqulov_
  Phone:(93) 083 64 60
                  
                  ''',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:20,
                    fontWeight: FontWeight.w500,
                  ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
