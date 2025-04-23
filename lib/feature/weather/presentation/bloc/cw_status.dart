import 'package:flutter/material.dart';

import '../../domain/entities/current_weather_entity.dart';

@immutable
abstract class CWStatus {}

class CWLoading extends CWStatus {}

class CWCompleted extends CWStatus {
  final CurrentWeatherEntity currentWeatherEntity;

  CWCompleted({required this.currentWeatherEntity});
}

class CWError extends CWStatus {
  final String msg;

  CWError({required this.msg});
}
