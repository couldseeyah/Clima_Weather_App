import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //get current location
  void getLocationData() async {
    try {
      var (weatherData, forecastData) = await WeatherModel().getLocationData();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(weatherData, forecastData),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 203, 209, 239).withOpacity(0.8),
            title: Text('Error',
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 9, 9),
                  fontSize: 18.0),
                ),
            content: Text(e.toString(),
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 70, 70),
                  fontSize: 15.0),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 183, 222).withOpacity(0.7),
      body: Center(
          child: SpinKitDoubleBounce(
        color: Color.fromARGB(255, 185, 204, 217),
        size: 70.0,
      )),
    );
  }
}
