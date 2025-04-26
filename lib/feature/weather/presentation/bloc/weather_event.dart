part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class LoadCWEvent extends WeatherEvent {
  final String cityName;

  LoadCWEvent({required this.cityName});
}


class LoadFWEvent extends WeatherEvent{
  final ForecastParams forecastParams;

  LoadFWEvent({required this.forecastParams});



}
