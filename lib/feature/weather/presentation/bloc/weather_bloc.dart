import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_weather/feature/weather/presentation/bloc/cw_status.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState(cwStatus: CWLoading())) {
    on<LoadCWEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
