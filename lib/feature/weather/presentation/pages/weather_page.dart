import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../bloc/cw_status.dart';
import '../bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final String cityName = "Shiraz";
  final String celsiusUniCode="\u00B0";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(LoadCWEvent(cityName: cityName));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state.cwStatus is CWLoading) {
                return Expanded(child: Center(child: DotLoadingWidget()));
              }

              if (state.cwStatus is CWCompleted) {
                final CurrentWeatherEntity currentWeatherEntity =
                    (state.cwStatus as CWCompleted).currentWeatherEntity;
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
          ),
        ],
      ),
    );
  }

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
      Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: SizedBox(
          width: width,
          height: 400,
          child: _pageViewBuilder(currentWeatherEntity),
        ),
      ),
      Constants.verticalSpacer20,
      _dotPageIndicator(),
    ],
  );

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
          _verticalDivider(),
          Constants.horizontalSpacer10,
          _currentWeatherMinTemp(currentWeatherEntity.main!.tempMin!),
        ],
      ),
    ],
  );

  Widget _verticalDivider() =>
      Container(color: Colors.white, height: 50, width: 2);

  Widget _currentWeatherDescription(String description) =>
      Text(description, style: TextStyle(color: Colors.grey, fontSize: 20));

  Widget _cityName(String cityName) =>
      Text(cityName, style: TextStyle(color: Colors.white, fontSize: 30));

  Widget _currentWeatherTemp(double temp) => Text(
    "${temp.round()}$celsiusUniCode",
    style: TextStyle(color: Colors.white, fontSize: 50),
  );

  Widget _currentWeatherMaxTemp(double maxTemp) => Column(
    children: [
      Text(
        "${maxTemp.round()}$celsiusUniCode",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),

      Text("max", style: TextStyle(color: Colors.white, fontSize: 20)),
    ],
  );

  Widget _currentWeatherMinTemp(double minTemp) => Column(
    children: [
      Text(
        "${minTemp.round()}$celsiusUniCode",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),

      Text("min", style: TextStyle(color: Colors.white, fontSize: 20)),
    ],
  );

  Widget _currentWeatherIcon(String description) =>
      AppBackground.setIconForMain(description);
}
