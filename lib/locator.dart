import 'package:get_it/get_it.dart';

import 'feature/bookmark/data/data_source/local/database.dart';
import 'feature/weather/data/data_source/remote/api_provider.dart';
import 'feature/weather/data/repositories/weather_repositoryImpl.dart';
import 'feature/weather/domain/repositories/weather_repository.dart';
import 'feature/weather/domain/use_cases/get_current_weather_use_case.dart';
import 'feature/weather/domain/use_cases/get_forecast_days_use_case.dart';
import 'feature/weather/presentation/bloc/weather_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //repositories
  locator.registerSingleton<WeatherRepository>(
    CurrentWeatherRepositoryImpl(locator()),
  );

  //current weather use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
    GetCurrentWeatherUseCase(locator()),
  );

  //forecast days use case
  locator.registerSingleton<GetForecastDaysUseCase>(
    GetForecastDaysUseCase(locator()),
  );

  //bloc
  locator.registerSingleton<WeatherBloc>(WeatherBloc(locator(), locator()));
}
