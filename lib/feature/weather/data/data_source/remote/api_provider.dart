import 'package:dio/dio.dart';

import '../../../../../core/params/forecast_params.dart';
import '../../../../../core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<Response> getCurrentWeather(String cityName) async {
    final Response result = await _dio.get(
      "/data/2.5/weather",
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
      "/data/2.5/forecast",
      queryParameters: {
        "lat": params.lat,
        "lon": params.lon,
        "appid": Constants.apikey,
        "units": Constants.units,
      },
    );

    print(result.realUri);

    return result;
  }
}
