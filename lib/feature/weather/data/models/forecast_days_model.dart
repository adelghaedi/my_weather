
import '../../domain/entities/forecast_days_entity.dart';
import 'current_weather_model.dart';

class ForecastDaysModel extends ForecastDaysEntity {
  const ForecastDaysModel({super.days});

  factory ForecastDaysModel.fromJson(Map<String, dynamic> json) {
    return ForecastDaysModel(
      days:
          (json["list"] as List)
              .map((element) => Day.fromJson(element))
              .toList(),
    );
  }
}

class Day {
  final num? dt;
  final Main? main;
  final List<Weather>? weathers;

  Day({required this.dt, required this.main, required this.weathers});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      dt: json["dt"],
      main: Main.fromJson(json["main"]),
      weathers:
          (json["weather"] as List).map((element) {
            return Weather.fromJson(element);
          }).toList(),
    );
  }
}
