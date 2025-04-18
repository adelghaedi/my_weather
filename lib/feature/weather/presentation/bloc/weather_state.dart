part of 'weather_bloc.dart';

class WeatherState {
  final CWStatus cwStatus;

  WeatherState({required this.cwStatus});

  WeatherState copyWith(CWStatus? newCWStatus) {
    return WeatherState(cwStatus: newCWStatus ?? this.cwStatus);
  }
}
