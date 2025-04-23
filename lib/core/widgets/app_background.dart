import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppBackground {
  static AssetImage getBackgroundImage() {
    final DateTime now = DateTime.now();
    final String hourNow = DateFormat("kk").format(now);
    if (6 > int.parse(hourNow)) {
      return AssetImage('assets/images/night_pic.jpg');
    } else if (18 > int.parse(hourNow)) {
      return AssetImage('assets/images/light_pic.jpg');
    } else {
      return AssetImage('assets/images/night_pic.jpg');
    }
  }

  static Image setIconForMain(description) {
    if (description == "clear sky") {
      return const Image(image: AssetImage('assets/images/icons8-sun-96.png'));
    } else if (description == "few clouds") {
      return Image(
        image: AssetImage('assets/images/icons8-partly-cloudy-day-80.png',),
      );
    } else if (description.contains("clouds")) {
      return Image(image: AssetImage('assets/images/icons8-clouds-80.png'));
    } else if (description.contains("thunderstorm")) {
      return Image(image: AssetImage('assets/images/icons8-storm-80.png'));
    } else if (description.contains("drizzle")) {
      return Image(image: AssetImage('assets/images/icons8-rain-cloud-80.png'));
    } else if (description.contains("rain")) {
      return Image(image: AssetImage('assets/images/icons8-heavy-rain-80.png'));
    } else if (description.contains("snow")) {
      return Image(image: AssetImage('assets/images/icons8-snow-80.png'));
    } else {
      return Image(
        image: AssetImage('assets/images/icons8-windy-weather-80.png'),
      );
    }
  }
}
