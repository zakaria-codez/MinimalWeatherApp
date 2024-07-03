import 'package:get/get.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherController extends GetxController {
  static const apiKey = '9737fc74506901cf915f4261908fa827';

  final _weatherService = WeatherServices(apikey: apiKey);

  Rx<Weather> wthr = Weather(
          cityName: "",
          mainCondition: "",
          temperature: 0,
          maxtemperature: 0,
          mintemperature: 0)
      .obs;

  fetchWeather() async {
    try {
      // Fetch current city
      String cityName = await _weatherService.getCurrentLocation();
      print(cityName);
      // Fetch weather for city
      final weather = await _weatherService.getWeather(cityName);
      wthr.value = weather;
      print(wthr.value.cityName);
      update();
    } catch (e) {
      throw Exception(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/lottie/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/lottie/cloud.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "assets/lottie/rainy.json";
      case 'thunderstorm':
        return "assets/lottie/thunder.json";
      case 'clear':
        return "assets/lottie/sunny.json";
      default:
        return "assets/lottie/sunny.json";
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }
}
