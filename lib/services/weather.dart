import 'package:flutter/material.dart';
import '../services/networking.dart';
import '../services/location_data.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String apiKey = ''; //Enter API Key here

class WeatherModel {
  (String, String) getTimeAndDate(int timestamp) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    String minute = dateTime.minute.toString();
    if (minute.length == 1) {
      minute = '0' + minute;
    }
    String time = dateTime.hour.toString() + ':' + minute;
    String date = DateFormat('MMMMEEEEd').format(dateTime);
    return (time, date);
  }

  (String, String) getTimeAndDay(int timestamp) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    String time = dateTime.hour.toString() + ':0' + dateTime.minute.toString();
    String day = DateFormat('MMMEd').format(dateTime);
    return (time, day);
  }

  Future getCityForecast(String city) async {
    NetworkService networkService = NetworkService(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');
    var forecastData = await networkService.getData();
    return forecastData;
  }

  Future getCityWeather(String city) async {
    NetworkService networkService = NetworkService(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    var weatherData = await networkService.getData();
    return weatherData;
  }

  Future getLocationData() async {
    Location location = Location();
    await location.getLocation();
    NetworkService networkService = NetworkService(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkService.getData();
    NetworkService networkService2 = NetworkService(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var forecastData = await networkService2.getData();
    return (weatherData, forecastData);
  }

  IconData getWeatherIconData(int condition) {
    if (condition < 300) {
      return FontAwesomeIcons.cloudBolt;
    } else if (condition < 400) {
      return FontAwesomeIcons.cloudShowersHeavy;
    } else if (condition < 600) {
      return FontAwesomeIcons.cloudRain;
    } else if (condition < 700) {
      return FontAwesomeIcons.snowflake;
    } else if (condition < 800) {
      return FontAwesomeIcons.smog;
    } else if (condition == 800) {
      return Icons.wb_sunny;
    } else if (condition <= 804) {
      return FontAwesomeIcons.cloud;
    } else {
      return Icons.question_mark_outlined;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
