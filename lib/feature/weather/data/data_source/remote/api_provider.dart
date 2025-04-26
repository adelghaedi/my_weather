import 'package:dio/dio.dart';

import '../../../../../core/params/forecast_params.dart';
import '../../../../../core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<Response> getCurrentWeather(String cityName) async {
    final Response result = await _dio.get(
      "${Constants.weatherBaseUrl}/data/2.5/weather",
      queryParameters: {
        "appid": Constants.apikey,
        "units": Constants.units,
        "q": cityName,
      },
    );
    return result;
  }

  Future<Response> sendRequestFor5DayForecast(ForecastParams params) async {
    final Response result = await _dio.get(
      "${Constants.weatherBaseUrl}/data/2.5/forecast",
      queryParameters: {
        "lat": params.lat,
        "lon": params.lon,
        "appid": Constants.apikey,
        "units": Constants.units,
      },
    );

    return result;
  }

  Future<Response> sendRequestCitySuggestion(String cityName) async {
    final Response result = await _dio.get(
      "${Constants.cityBaseUrl}/v1/geo/cities",
      queryParameters: {"limit": 7, "offset": 0, "namePrefix": cityName},
    );

    return result;
  }
}
