import 'package:geolocator/geolocator.dart';

class Location{

  late  double long;
  late double lat;

  Future<void> getLocation()async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    long=position.longitude;
    lat=position.latitude;

  }

}

