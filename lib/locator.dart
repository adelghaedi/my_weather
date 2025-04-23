import 'package:get_it/get_it.dart';

import 'feature/weather/data/data_source/remote/api_provider.dart';
import 'feature/weather/data/repositories/current_weather_repositoryImpl.dart';
import 'feature/weather/domain/repositories/current_weather_repository.dart';
import 'feature/weather/domain/use_cases/get_current_weather_use_case.dart';
import 'feature/weather/presentation/bloc/weather_bloc.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  //repositories
  locator.registerSingleton<CurrentWeatherRepository>(
    CurrentWeatherRepositoryImpl(locator()),
  );

  //use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
    GetCurrentWeatherUseCase(locator()),
  );

  //bloc
  locator.registerSingleton<WeatherBloc>(WeatherBloc(locator()));
}
