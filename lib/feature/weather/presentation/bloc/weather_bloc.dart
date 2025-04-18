import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {

    on<LoadCWEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
