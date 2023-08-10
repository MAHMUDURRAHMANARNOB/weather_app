// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

const apiKEY = "5a18fc6e52dc7342ee016a20e95a106c";

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    /*getLocation();*/
    // fetchData();
    getWeatherLocationData();
  }

  void getWeatherLocationData() async {
    Location location = Location();
    await location.getLocation();

    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitudeLocation}&lon=${location.longitudeLocation}&appid=$apiKEY&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();

    print(weatherData.toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
