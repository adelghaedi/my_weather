import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../../data/models/suggest_city_model.dart';
import '../entities/current_weather_entity.dart';
import '../entities/forecast_days_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeatherData(
    String cityName,
  );

  Future<DataState<ForecastDaysEntity>> fetchForecastDaysData(
    ForecastParams forecastParams,
  );

  Future<List<Data>> fetchCitySuggestionData(String cityName);
}
