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
}
