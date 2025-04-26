import 'package:equatable/equatable.dart';

import '../../data/models/forecast_days_model.dart';

class ForecastDaysEntity extends Equatable {
  final List<Day>? days;

  const ForecastDaysEntity({required this.days});

  @override
  List<Object?> get props => [days];
}
