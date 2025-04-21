import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/weather/presentation/bloc/weather_bloc.dart';
import 'locator.dart';

import 'core/widgets/main_wrapper.dart';

void main() async {
  await setup();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => locator<WeatherBloc>())],
        child: MainWrapper(),
      ),
    ),
  );
}
