part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class LoadCWEvent extends WeatherEvent {
  final String cityName;

  LoadCWEvent({required this.cityName});
}
