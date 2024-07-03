import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class WeatherServices {
  final String apikey;
  WeatherServices({required this.apikey});
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=9737fc74506901cf915f4261908fa827&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load weather data :(');
    }
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
//fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
//convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
//extract the city nam e from the first placemark
    String? city = placemarks[0].administrativeArea;

    return city ?? "";
  }
}
