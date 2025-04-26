import 'package:equatable/equatable.dart';

import '../../domain/entities/forecast_days_entity.dart';

abstract class FWStatus extends Equatable {}

class FWLoading extends FWStatus {
  @override
  List<Object?> get props => [];
}

class FWCompleted extends FWStatus {
  final ForecastDaysEntity forecastDaysEntity;

  FWCompleted({required this.forecastDaysEntity});

  @override
  List<Object?> get props => [forecastDaysEntity];
}

class FWError extends FWStatus {
  final String msg;

  FWError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
