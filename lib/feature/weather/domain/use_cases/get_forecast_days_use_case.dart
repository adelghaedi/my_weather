import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/forecast_days_entity.dart';
import '../repositories/weather_repository.dart';

class GetForecastDaysUseCase
    extends UseCase<DataState<ForecastDaysEntity>, ForecastParams> {
  final WeatherRepository _repository;

  GetForecastDaysUseCase(this._repository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) =>
      _repository.fetchForecastDaysData(params);
}
