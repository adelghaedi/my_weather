
import '../../../../core/use_case/use_case.dart';
import '../../data/models/suggest_city_model.dart';
import '../repositories/weather_repository.dart';

class GetCitySuggestionUseCase extends UseCase<List<Data>, String> {
  final WeatherRepository weatherRepository;

  GetCitySuggestionUseCase({required this.weatherRepository});

  @override
  Future<List<Data>> call(String cityName) =>
      weatherRepository.fetchCitySuggestionData(cityName);
}
