import 'package:flutter/material.dart';
import 'package:weather_forecast_flutter/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  MainScreen({@required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  String cityName;
  var currentTemp;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      temperature = weatherData.currentTemperature.round();
      backgroundImage = weatherDisplayData.wheatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      cityName = weatherData.cityName;
      if(temperature > 200)
         currentTemp = temperature/10;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints:
            BoxConstraints.expand(), // resmin tüm ekranlarda aynı gözükmesi
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Container(child: weatherDisplayIcon),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                '$currentTemp °C',
                style: TextStyle(
                    color: Colors.white, fontSize: 70.0, letterSpacing: -5),
              ),
            ),
            SizedBox(height: 400),
            Center(
              child: Text(cityName,
                style: TextStyle(
                    color: Colors.white, fontSize: 40.0, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
