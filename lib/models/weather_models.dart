class Weather {
  final String cityName;
  final double temperature;
  final double maxtemperature;
  final double mintemperature;
  final String mainCondition;
  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required this.maxtemperature,
      required this.mintemperature});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        maxtemperature: json['main']['temp_max'].toDouble(),
        mintemperature: json['main']['temp_min'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}
