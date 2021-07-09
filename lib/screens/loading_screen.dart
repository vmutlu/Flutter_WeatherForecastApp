import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_forecast_flutter/screens/main_screen.dart';
import 'package:weather_forecast_flutter/utils/location.dart';
import 'package:weather_forecast_flutter/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<LoadingScreen> {
  LocationHelper locationHelper;
  Future<void> getLocationData() async {
    locationHelper = LocationHelper();
    await locationHelper.getCurrentLocation();

    if (locationHelper.latitude == null || locationHelper.longitude == null) {
      print("Location not found");
    } else {
      print("Latitude: " + locationHelper.latitude.toString());
      print("Longitude:" + locationHelper.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationHelper: locationHelper);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print('Error');
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.blue])),
        child: Center(
          child: SpinKitDualRing(
            color: Colors.white,
            size: 150.0,
            duration: Duration(microseconds: 855555),
          ),
        ),
      ),
    );
  }
}
