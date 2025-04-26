import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/get_current_weather_use_case.dart';
import '../../domain/use_cases/get_forecast_days_use_case.dart';
import 'cw_status.dart';
import 'fw_status.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastDaysUseCase getForecastDaysUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase, this.getForecastDaysUseCase)
    : super(WeatherState(cwStatus: CWLoading(), fwStatus: FWLoading())) {
    on<LoadCWEvent>((event, emit) async {
      emit(state.copyWith(newCWStatus: CWLoading()));
      final DataState dataState = await getCurrentWeatherUseCase(
        event.cityName,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newCWStatus: CWCompleted(currentWeatherEntity: dataState.data),
          ),
        );
      }

      if (dataState is DataError) {
        emit(state.copyWith(newCWStatus: CWError(msg: dataState.error!)));
      }
    });

    on<LoadFWEvent>((event, emit) async {
      emit(state.copyWith(newFWStatus: FWLoading()));

      final DataState dataState = await getForecastDaysUseCase(
        event.forecastParams,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newFWStatus: FWCompleted(forecastDaysEntity: dataState.data),
          ),
        );
      }

      if (dataState is DataError) {
        emit(state.copyWith(newFWStatus: FWError(msg: dataState.error!)));
      }
    });
  }
}
