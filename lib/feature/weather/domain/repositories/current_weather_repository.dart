import '../../../../core/resources/data_state.dart';
import '../entities/current_weather_entity.dart';

abstract class CurrentWeatherRepository{
  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeatherData(final String cityName);
}