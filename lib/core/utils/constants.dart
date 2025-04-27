import 'package:flutter/material.dart';

class Constants {
  //constants api provider
  static const String apikey = "092945c8c3b6126e483d21ba587d0484";
  static const String weatherBaseUrl = "https://api.openweathermap.org";
  static const String cityBaseUrl="http://geodb-free-service.wirefreethought.com";
  static const String units = "metric";

  //constants weather page

  static const String defaultCityCurrentWeather = "Shiraz";
  static const String minLabel = "min";
  static const String maxLabel = "max";
  static const String citySuggestionTextFieldHint = "Enter a city";
  static const String windSpeedLabel = "wind speed";
  static const String sunriseLabel = "sunrise";
  static const String sunsetLabel = "sunset";
  static const String humidityLabel = "humidity";
  static const String celsiusUniCode = "\u00B0";



  static const SizedBox verticalSpacer20 = SizedBox(height: 20);
  static const SizedBox verticalSpacer50 = SizedBox(height: 50);
  static const SizedBox horizontalSpacer10 = SizedBox(width: 10);
}
