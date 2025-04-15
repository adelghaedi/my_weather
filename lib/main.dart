import 'package:flutter/material.dart';
import 'package:my_weather/core/widgets/main_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainWrapper());
  }
}
