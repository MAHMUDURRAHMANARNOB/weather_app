// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/custom_paint.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({super.key, required this.locationWeather});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late var temp;
  late var maxTemp;
  late var minTemp;
  late var windSpeed;
  late var feelsLike;
  late var humidity;
  late var locationName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        maxTemp = 0;
        minTemp = 0;
        windSpeed = 0;
        feelsLike = 0;
        humidity = 0;
        locationName = 'Error!';
        return;
      }
      /*var data = widget.locationWeather;*/
      num tempe = weatherData['main']['temp'];
      temp = tempe.toInt();
      num maxTempe = weatherData['main']['temp_max'];
      maxTemp = maxTempe.toInt();
      num minTempe = weatherData['main']['temp_min'];
      minTemp = minTempe.toInt();
      feelsLike = weatherData['main']['feels_like'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'] *
          3.6; // wind speed comes in ms-1. so had to multiply with 3.6 since 1 ms-1 == 3.6 kmh-1.
      locationName = weatherData['name'];

      print('$temp : $locationName : $windSpeed : $humidity : $feelsLike');
    });
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
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temp°C',
                        style: kTempTextStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateUI(widget.locationWeather);
                        ;
                      },
                      child: Image.asset(
                        'assets/images/ic_current_location.png',
                        width: 32.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    GestureDetector(
                      onTap: () async {
                        var typedCityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        print(typedCityName);
                        if (typedCityName != null) {
                          var weatherData = await WeatherModel()
                              .getCityWeather(typedCityName);
                          updateUI(weatherData);
                        }
                      },
                      child: Image.asset(
                        'assets/images/ic_search.png',
                        width: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 16.0),
                    Image.asset(
                      'assets/images/ic_location_pin.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        '$locationName',
                        textAlign: TextAlign.center,
                        style: kSmallTextStyle.copyWith(
                          fontSize: 16.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 190,
                child: CustomPaint(
                  painter: MyCustomPaint(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 24.0,
                        ),
                        child: Text(
                          'Weather Today',
                          style: kConditionTextStyle.copyWith(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConditionRow(
                            icon: 'assets/images/ic_temp.png',
                            title: "Min Temp",
                            value: '$minTemp°C',
                          ),
                          ConditionRow(
                            icon: 'assets/images/ic_temp.png',
                            title: "Max Temp",
                            value: '$maxTemp°C',
                          ),
                          ConditionRow(
                            icon: 'assets/images/ic_wind_speed.png',
                            title: "Wind Speed",
                            value: '${windSpeed.toStringAsFixed(1)} Km/h',
                          ),
                          ConditionRow(
                            icon: 'assets/images/ic_humidity.png',
                            title: "humidity",
                            value: '$humidity%',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConditionRow extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const ConditionRow(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            title,
            style: kConditionTextStyleSmall,
          ),
        ),
        Text(
          value,
          style: kConditionTextStyle,
        )
      ],
    );
  }
}
