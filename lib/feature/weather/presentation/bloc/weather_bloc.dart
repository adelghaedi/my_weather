import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_weather/core/resources/data_state.dart';

import '../../domain/use_cases/get_current_weather_use_case.dart';
import 'cw_status.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase)
    : super(WeatherState(cwStatus: CWLoading())) {
    on<LoadCWEvent>((event, emit) async {
      emit(state.copyWith(newCWStatus: CWLoading()));
      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newCWStatus: CWCompleted(entity: dataState.data)));
      }

      if (dataState is DataError) {
        emit(state.copyWith(newCWStatus: CWError(msg: dataState.error!)));
      }
    });
  }
}
