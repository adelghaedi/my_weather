import 'package:dio/dio.dart';

import '../../../../../core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<dynamic> getCurrentWeather(final String cityName) async {
    final Response result = await _dio.get(
      "/data/2.5/weather",
      queryParameters: {
        "appid": Constants.apikey,
        "units": "metric",
        "q": cityName,
      },
    );
    return result;
  }
}
