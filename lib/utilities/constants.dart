import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontSize: 100.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kWeatherTypeTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kWeatherDetailsTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kWeatherDetailsTextStyle2 = TextStyle(
  fontSize: 12.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kDateTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 35.0,
);

const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 26.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kConditionTextStyle = TextStyle(
  fontSize: 120.0,
);

const kcityNameTextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

const kTimeTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kForecastTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kTextInput = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Color.fromARGB(255, 147, 221, 255),
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

