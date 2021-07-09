import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

const apiKey = "b6982f07c41346fc75bd25bd9dab2ec0";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage wheatherImage;

  WeatherDisplayData({@required this.weatherIcon, this.wheatherImage});
}

class WeatherData {
  WeatherData({@required this.locationHelper});

  LocationHelper locationHelper;
  double currentTemperature;
  int currentCondition;
  String cityName;

  var endpointUrl = 'https://api.openweathermap.org/data/2.5/weather';
  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<void> getCurrentTemperature() async {
    var uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': ['${locationHelper.latitude}'],
        'lon': ['${locationHelper.longitude}'],
        'appid': ['${apiKey}']
      },
    );
    print(uri);

    Response response = await get(uri);

    if (response.statusCode == 200) {
      String data = response.body;

      var current = jsonDecode(data);

      try {
        currentTemperature = current['main']['temp'];
        currentCondition = current['weather'][0]['id'];
        cityName = current['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API not data");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75.0,
            color: Colors.white,
          ),
          wheatherImage: AssetImage('assests/bulutlu.png'));
    } else {
      var now = new DateTime.now();
      if (now.hour > 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
              color: Colors.white,
            ),
            wheatherImage: AssetImage('assests/gece.png'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            wheatherImage: AssetImage('assests/gunesli.png'));
      }
    }
  }
}
