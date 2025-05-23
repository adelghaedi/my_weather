import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/params/forecast_params.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../../../locator.dart';
import '../../data/models/suggest_city_model.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/entities/forecast_days_entity.dart';
import '../../domain/use_cases/get_city_suggestion_use_case.dart';
import '../bloc/cw_status.dart';
import '../bloc/fw_status.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/day_weather_view.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController suggestionCityController =
      TextEditingController();

  final GetCitySuggestionUseCase getCitySuggestionUseCase =
      GetCitySuggestionUseCase(weatherRepository: locator());

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(
      context,
    ).add(LoadCWEvent(cityName: Constants.defaultCityCurrentWeather));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Constants.verticalSpacer20,
          _citySuggestionTextField(context, width),
          _currentWeatherBlocBuilder(height, width),
        ],
      ),
    );
  }

  Widget _citySuggestionTextField(BuildContext context, double width) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: TypeAheadField<Data>(
          builder: _citySuggestionBuilder,
          controller: suggestionCityController,
          suggestionsCallback: (String prefix) {
            return getCitySuggestionUseCase(prefix);
          },
          itemBuilder: _citySuggestionItemBuilder,
          onSelected: _citySuggestionOnSelected,
        ),
      );

  Widget _citySuggestionBuilder(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );

    return TextField(
      controller: controller,
      autofocus: false,
      focusNode: focusNode,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        hintText: Constants.citySuggestionTextFieldHint,
        hintStyle: TextStyle(color: Colors.white),
        border: outlineInputBorder,
      ),
    );
  }

  void _citySuggestionOnSelected(Data model) {
    BlocProvider.of<WeatherBloc>(
      context,
    ).add(LoadCWEvent(cityName: model.name!));
  }

  Widget _citySuggestionItemBuilder(context, Data model) => ListTile(
    leading: const Icon(Icons.location_on),
    title: Text(model.name!),
    subtitle: Text("${model.region}, ${model.country}"),
  );

  Widget _currentWeatherBlocBuilder(double height, double width) =>
      BlocBuilder<WeatherBloc, WeatherState>(
        buildWhen: (previous, current) {
          if (previous.cwStatus == current.cwStatus) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state.cwStatus is CWLoading) {
            return Expanded(child: Center(child: DotLoadingWidget()));
          }

          if (state.cwStatus is CWCompleted) {
            final CurrentWeatherEntity currentWeatherEntity =
                (state.cwStatus as CWCompleted).currentWeatherEntity;

            final ForecastParams params = ForecastParams(
              lat: currentWeatherEntity.coord!.lat!,
              lon: currentWeatherEntity.coord!.lon!,
            );
            BlocProvider.of<WeatherBloc>(
              context,
            ).add(LoadFWEvent(forecastParams: params));

            return Expanded(
              child: _currentWeatherCompletedWidget(
                height,
                width,
                currentWeatherEntity,
              ),
            );
          }

          if (state.cwStatus is CWError) {}

          return Container();
        },
      );

  Widget _dotPageIndicator() => Center(
    child: SmoothPageIndicator(
      effect: ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        spacing: 5,
        activeDotColor: Colors.white,
      ),
      controller: _pageController,
      count: 2,
      onDotClicked: _dotPageIndicatorOnClicked,
    ),
  );

  void _dotPageIndicatorOnClicked(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _currentWeatherCompletedWidget(
    double height,
    double width,
    CurrentWeatherEntity currentWeatherEntity,
  ) => ListView(
    children: [
      Constants.verticalSpacer20,
      SizedBox(
        width: width,
        height: height / 2 < 400 ? 400 : height / 2,
        child: _pageViewBuilder(currentWeatherEntity),
      ),
      Constants.verticalSpacer20,
      _dotPageIndicator(),
      Constants.verticalSpacer20,
      _divider(),
      Constants.verticalSpacer20,
      _forecastWeather(width, height),
      Constants.verticalSpacer20,
      _divider(),
      Constants.verticalSpacer20,
      _detailsCurrentWeatherWidget(currentWeatherEntity, height),
      Constants.verticalSpacer20,
    ],
  );

  Widget _detailsCurrentWeatherWidget(
    CurrentWeatherEntity currentWeatherEntity,
    double height,
  ) {
    final String sunrise = DateConverter.changeDtToDateTimeHour(
      currentWeatherEntity.sys!.sunrise,
      currentWeatherEntity.timezone,
    );

    final String sunset = DateConverter.changeDtToDateTimeHour(
      currentWeatherEntity.sys!.sunset,
      currentWeatherEntity.timezone,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _labelAndValueWidget(
          height,
          Constants.windSpeedLabel,
          "${currentWeatherEntity.wind!.speed!} m/s",
        ),
        Constants.horizontalSpacer10,
        _divider30(),
        Constants.horizontalSpacer10,
        _labelAndValueWidget(height, Constants.sunriseLabel, sunrise),
        Constants.horizontalSpacer10,
        _divider30(),
        Constants.horizontalSpacer10,
        _labelAndValueWidget(height, Constants.sunsetLabel, sunset),
        Constants.horizontalSpacer10,
        _divider30(),
        Constants.horizontalSpacer10,
        _labelAndValueWidget(
          height,
          Constants.humidityLabel,
          "${currentWeatherEntity.main!.humidity}%",
        ),
      ],
    );
  }

  Widget _labelAndValueWidget(double height, String label, String value) =>
      Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: height * 0.017, color: Colors.amber),
          ),
          Text(
            value,
            style: TextStyle(fontSize: height * 0.016, color: Colors.white),
          ),
        ],
      );

  Widget _divider() => Divider(
    height: 2,
    thickness: 1.5,
    color: Colors.grey.withValues(alpha: 0.5),
  );

  Widget _forecastWeather(double width, double height) => Container(
    alignment: Alignment.center,
    width: width,
    height: height / 8 < 100 ? 100 : height / 8,
    child: _forecastWeatherBlocBuilder(),
  );

  Widget _forecastWeatherBlocBuilder() =>
      BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.fwStatus is FWLoading) {
            return DotLoadingWidget();
          }
          if (state.fwStatus is FWCompleted) {
            final ForecastDaysEntity forecastDaysEntity =
                (state.fwStatus as FWCompleted).forecastDaysEntity;

            return _forecastWeatherCompletedWidget(forecastDaysEntity);
          }

          if (state.fwStatus is FWError) {}

          return Container();
        },
      );

  Widget _forecastWeatherCompletedWidget(
    ForecastDaysEntity forecastDaysEntity,
  ) {
    final int listViewItemCount = (forecastDaysEntity.days!.length) ~/ 8;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: listViewItemCount,
      itemBuilder: (context, index) {
        return DayWeatherView(
          day: forecastDaysEntity.days![((index + 1) * 8) - 1],
        );
      },
    );
  }

  Widget _pageViewBuilder(CurrentWeatherEntity currentWeatherEntity) =>
      PageView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        allowImplicitScrolling: true,
        itemCount: 2,
        controller: _pageController,

        itemBuilder:
            (context, index) =>
                index == 0
                    ? _currentWeather(currentWeatherEntity)
                    : Container(color: Colors.amber),
      );

  Widget _currentWeather(CurrentWeatherEntity currentWeatherEntity) => Column(
    children: [
      Constants.verticalSpacer20,
      _cityName(currentWeatherEntity.name!),
      Constants.verticalSpacer20,
      _currentWeatherDescription(currentWeatherEntity.weather![0].description!),
      Constants.verticalSpacer20,
      _currentWeatherIcon(currentWeatherEntity.weather![0].description!),
      Constants.verticalSpacer20,
      _currentWeatherTemp(currentWeatherEntity.main!.temp!),
      Constants.verticalSpacer20,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _currentWeatherMaxTemp(currentWeatherEntity.main!.tempMax!),
          Constants.horizontalSpacer10,
          _divider50(),
          Constants.horizontalSpacer10,
          _currentWeatherMinTemp(currentWeatherEntity.main!.tempMin!),
        ],
      ),
    ],
  );

  Widget _divider50() => Container(color: Colors.grey, height: 50, width: 1.5);

  Widget _divider30() => Container(color: Colors.grey, height: 30, width: 1.5);

  Widget _currentWeatherDescription(String description) =>
      Text(description, style: TextStyle(color: Colors.grey, fontSize: 20));

  Widget _cityName(String cityName) =>
      Text(cityName, style: TextStyle(color: Colors.white, fontSize: 30));

  Widget _currentWeatherTemp(double temp) => Text(
    "${temp.round()}${Constants.celsiusUniCode}",
    style: TextStyle(color: Colors.white, fontSize: 50),
  );

  Widget _currentWeatherMaxTemp(double maxTemp) => Column(
    children: [
      Text(
        Constants.maxLabel,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      Text(
        "${maxTemp.round()}${Constants.celsiusUniCode}",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ],
  );

  Widget _currentWeatherMinTemp(double minTemp) => Column(
    children: [
      Text(
        Constants.minLabel,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      Text(
        "${minTemp.round()}${Constants.celsiusUniCode}",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ],
  );

  Widget _currentWeatherIcon(String description) =>
      AppBackground.setIconForMain(description);
}
