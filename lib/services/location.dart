import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location {
  late double latitudeLocation;
  late double longitudeLocation;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitudeLocation = position.latitude;
      longitudeLocation = position.longitude;

      /*print('$latitudeLocation : $longitudeLocation');*/
    } catch (e) {
      print(e.toString());
    }
  }
}
