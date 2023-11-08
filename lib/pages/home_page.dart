// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:weather_app/model/city_weather_model.dart';
// import 'package:weather_app/model/hourly_weather_model.dart';
// import 'package:weather_app/model/weather_model.dart';
// import 'package:weather_app/services/city_weather_service.dart';
// import 'package:weather_app/services/current_weather.dart';
// import 'package:weather_app/services/hourly_weather_service.dart';
// import 'package:weather_app/utils/utils.dart';
//
// import '../services/location_service.dart';
// import '../utils/app_colors.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   CurrentWeatherService currentWeatherService = CurrentWeatherService();
//   HourlyWeatherService hourlyWeatherService = HourlyWeatherService();
//   CityWeatherService cityWeatherService = CityWeatherService();
//   List<String> cities = [
//     "Andijan",
//     "Bukhara",
//     "Fergana",
//     "Jizzakh",
//     "Namangan",
//     "Navoi",
//     "Samarkand",
//     "Tashkent",
//     "Nukus"
//   ];
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   void getLocation() async {
//     Location location = Location();
//     await location.getLocation();
//     print(location.lat);
//     print(location.long);
//   }
//
//   @override
//   void initState() {
//     _determinePosition();
//     getLocation();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             AppPng.bgSplash,
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   AppColors.gradientColor1,
//                   AppColors.gradientColor2,
//                   AppColors.gradientColor3,
//                 ],
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 40,
//                     right: 15,
//                     left: 15,
//                     bottom: 30,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         height: 35,
//                         width: 35,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             gradient: const LinearGradient(
//                               begin: Alignment.center,
//                               end: Alignment.center,
//                               colors: [
//                                 AppColors.containerColor1,
//                                 AppColors.containerColor2,
//                               ],
//                             )),
//                       ),
//
//                       Container(
//                           height: 35,
//                           width: 35,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               gradient: const LinearGradient(
//                                 begin: Alignment.center,
//                                 end: Alignment.center,
//                                 colors: [
//                                   AppColors.containerColor1,
//                                   AppColors.containerColor2,
//                                 ],
//                               )),),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//
//
//
//                       Padding(
//                           padding: const EdgeInsets.only(top: 28),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(top: 6),
//
//
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 70, right: 54, top: 19, bottom: 30),
//                   child: Container(
//                     height: 95,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         gradient: const LinearGradient(
//                             begin: Alignment.center,
//                             end: Alignment.center,
//                             colors: [
//                               AppColors.containerColor1,
//                               AppColors.containerColor2,
//                             ])),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 230,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 15, right: 5),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 5),
//
//                         ),
//                         SizedBox(
//                           height: 6,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 15,
//                     ),
//                     child: Column(
//                       children: [
//
//                         SizedBox(
//                           height: 50,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             physics: const BouncingScrollPhysics(),
//                             itemCount: 3,
//                             itemBuilder: (context, index) {
//                               return
//                               Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 5),
//                                         child: Container(
//                                           height: 50,
//                                           width: 160,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               gradient: const LinearGradient(
//                                                   begin: Alignment.center,
//                                                   end: Alignment.center,
//                                                   colors: [
//                                                     AppColors.containerColor1,
//                                                     AppColors.containerColor2,
//                                                   ])),
//                                         ),
//                                       );
//                                     }
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 100,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class buildWeatherContainer extends StatelessWidget {
//   buildWeatherContainer({
//     super.key,
//     required this.text,
//     required this.text1,
//     required this.image,
//   });
//
//   String text;
//   String text1;
//   String image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Image.asset(image),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         Text(
//           text1,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 12,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }
