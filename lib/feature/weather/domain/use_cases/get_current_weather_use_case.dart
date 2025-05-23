import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/current_weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase
    extends UseCase<DataState<CurrentWeatherEntity>, String> {
  final WeatherRepository _repository;

  GetCurrentWeatherUseCase(this._repository);

  @override
  Future<DataState<CurrentWeatherEntity>> call(final String cityName) =>
      _repository.fetchCurrentWeatherData(cityName);
}
