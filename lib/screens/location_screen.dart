import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';
import 'reusable_card.dart';
import '../utilities/forecast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;
  final dynamic forecastData;
  LocationScreen(this.weatherData, this.forecastData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool loading = false;
  WeatherModel weatherModel = WeatherModel();
  String cityName = '';
  String time = '';
  int temperature = 0;
  IconData weatherIcon = Icons.error;
  String weatherType = '';
  String date = '';
  double windSpeed = 0;
  int humidity = 0;
  dynamic atmosphericPressure = 0;
  List<Forecast> forecastList = [];

  void updateUI(dynamic weatherData, forecastData) {
    setState(() {
      if (weatherData == null) {
        time = '???';
        weatherType = '';
        date = 'Error';
        temperature = 0;
        weatherIcon = Icons.error;
        cityName = '';
        windSpeed = 0;
        humidity = 0;
        atmosphericPressure = 0;
        forecastList.clear();
        return;
      }
      // setting required fields to display via weatherdata object
      int timeStamp = weatherData['dt'];
      int timeZone = weatherData['timezone'];
      timeStamp = timeStamp + timeZone;
      var (a, b) = weatherModel.getTimeAndDate(timeStamp);
      time = a;
      date = b;
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIconData(condition);
      cityName = weatherData['name'];
      weatherType = weatherData['weather'][0]['main'];
      var tempWindSpeed = weatherData['wind']['speed'];
      windSpeed = (tempWindSpeed * 3.6); //conversion to km per hour
      humidity = weatherData['main']['humidity'];
      atmosphericPressure = weatherData['main']['pressure'];

      forecastList.clear();

      for (int i = 0; i < 40; i++) {
        int timestamp = forecastData['list'][i]['dt'];
        timestamp = timestamp + timeZone;
        var (a, b) = weatherModel.getTimeAndDay(timestamp);
        String day = b;
        String time = a;
        var temp = forecastData['list'][i]['main']['temp'];
        int temperature = temp.toInt();
        var condition = forecastData['list'][i]['weather'][0]['id'];
        String icon = weatherModel.getWeatherIcon(condition);
        Forecast forecast =
            Forecast(day: day, time: time, temp: temperature, icon: icon);
        forecastList.add(forecast);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData, widget.forecastData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: loading ? Center(
              child: SpinKitDoubleBounce(
                color: Color.fromARGB(255, 162, 217, 214),
                size: 70.0,
              ),
            ) :
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            setState(() async {
                              var (weatherdata, forecastdata) =
                                  await weatherModel.getLocationData();
                              updateUI(weatherdata, forecastdata);
                              loading = false;
                            });
                            
                          },
                          child: Icon(
                            Icons.near_me,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                        Text(
                          cityName,
                          style: kcityNameTextStyle,
                        ),
                        TextButton(
                          onPressed: () async {
                            var cityName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CityScreen(),
                              ),
                            );
                            setState(() {
                              loading = true;
                            });
                            if (cityName != null) {
                              var weatherData =
                                  await weatherModel.getCityWeather(cityName);
                              var forecastData =
                                  await weatherModel.getCityForecast(cityName);
                              updateUI(weatherData, forecastData);
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Icon(
                            Icons.location_city,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      time,
                      style: kTimeTextStyle,
                    ),
                  ],
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                '$temperature°',
                                style: kTempTextStyle,
                              ),
                              Text(
                                weatherType,
                                style: kWeatherTypeTextStyle,
                              ),
                            ],
                          ),
                          Icon(
                            weatherIcon,
                            size: 100.0,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          date,
                          style: kDateTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: ReusableCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.air,
                                  size: 40,
                                ),
                              ),
                              Text(windSpeed.toStringAsFixed(1),
                                  style: kWeatherDetailsTextStyle),
                              Text('km/h', style: kWeatherDetailsTextStyle2),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:
                                    Icon(Icons.water_drop_outlined, size: 40),
                              ),
                              Text(humidity.toString(),
                                  style: kWeatherDetailsTextStyle),
                              Text('%', style: kWeatherDetailsTextStyle2),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.schedule_outlined, size: 40),
                              ),
                              Text(atmosphericPressure.toString(),
                                  style: kWeatherDetailsTextStyle),
                              Text('hPa', style: kWeatherDetailsTextStyle2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ReusableCard(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(5),
                      itemCount: forecastList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${forecastList[index].time}',
                                  style: kForecastTextStyle),
                              Text('${forecastList[index].day}',
                                  style: kForecastTextStyle),
                              Text('${forecastList[index].temp}°',
                                  style: kForecastTextStyle),
                              Text('${forecastList[index].icon}',
                                  style: kForecastTextStyle),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
