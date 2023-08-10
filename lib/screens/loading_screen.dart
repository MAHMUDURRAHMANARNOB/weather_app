// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    /*getLocation();*/
    fetchData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();

    print(location.latitudeLocation);
    print(location.longitudeLocation);
  }

  void fetchData() async {
    http.Response response = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather"),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
