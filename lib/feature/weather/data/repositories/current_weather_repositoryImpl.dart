import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/repositories/current_weather_repository.dart';
import '../data_source/remote/api_provider.dart';
import '../models/current_weather_model.dart';

class CurrentWeatherRepositoryImpl extends CurrentWeatherRepository {
  ApiProvider apiProvider;

  CurrentWeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeatherData(
    final String cityName,
  ) async {
    try {
      Response response = await apiProvider.getCurrentWeather(cityName);

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
}
