import 'package:dio/dio.dart';

class IconService{

  Future getcurrentIcon(String icon)async{
    
    final dio=Dio();
    
    var iconResponse=dio.get('https://openweathermap.org/img/wn/${icon}@2x.png');

  }


}