import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../domain/models.dart';
import '../../domain/weather_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //api key
  final _weatherService = WeatherService();
  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'show rain':
        return 'assets/rainy_sunny.json';
      case 'thunderstorm':
        return 'assets/rainny.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  //weather animations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Weather"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city..."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //tempweature
            Text('${_weather?.temprature.round()}°C'),

            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
