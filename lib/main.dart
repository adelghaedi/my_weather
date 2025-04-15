import 'package:flutter/material.dart';
import 'package:my_weather/core/widgets/main_wrapper.dart';
import 'package:my_weather/feature/weather/data/data_source/remote/api_provider.dart';
import 'package:my_weather/feature/weather/data/repositories/current_weather_repositoryImpl.dart';
import 'package:my_weather/feature/weather/domain/usecases/get_current_weather_usecase.dart';

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
