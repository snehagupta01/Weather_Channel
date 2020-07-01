import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '3c78ee89bff4691480c85ed31193fedf';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  void getLocationData() async {
    Location location = new Location();
    await location.getCurrentLocation();
//    print(location.latitude);
//    print(location.longitude);
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = new NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    print(weatherData);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen();
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    ));
  }
}
