import 'package:dio/dio.dart';


import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/entities/forecast_days_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_source/remote/api_provider.dart';
import '../models/current_weather_model.dart';
import '../models/forecast_days_model.dart';

class CurrentWeatherRepositoryImpl extends WeatherRepository {
  ApiProvider apiProvider;

  CurrentWeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeatherData(
    String cityName,
  ) async {
    try {
      final Response response = await apiProvider.getCurrentWeather(cityName);

      if (response.statusCode == 200) {
        CurrentWeatherEntity currentWeatherEntity =
            CurrentWeatherModel.fromJson(response.data);

        return DataSuccess(currentWeatherEntity);
      } else {
        return DataError("Something Went Wrong. try again...");
      }
    } catch (e) {
      return DataError("please check your connection...");
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastDaysData(
    ForecastParams forecastParams,
  ) async {
    final Response response = await apiProvider.sendRequestFor5DayForecast(
      forecastParams,
    );

    try {
      if (response.statusCode == 200) {
        final ForecastDaysEntity forecastDaysEntity = ForecastDaysModel.fromJson(
          response.data,
        );

        return DataSuccess(forecastDaysEntity);
      } else {
        return DataError("Something Went Wrong. try again...");
      }
    } catch (e) {
      return DataError("please check your connection...");
    }
  }
}
