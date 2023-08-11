import 'package:weather_app/services/location.dart';

import 'network.dart';

const apiKey = '5a18fc6e52dc7342ee016a20e95a106c';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    String url =
        "$openWeatherMapURL?lat=${location.latitudeLocation}&lon=${location.longitudeLocation}&appid=$apiKey&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
    /*print("hello"+weatherData.toString());*/
  }
}
