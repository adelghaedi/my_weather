import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../core/widgets/app_background.dart';
import '../../data/models/forecast_days_model.dart';

class DayWeatherView extends StatefulWidget {
  final Day day;

  const DayWeatherView({super.key, required this.day});

  @override
  State<DayWeatherView> createState() => _DayWeatherViewState();
}

class _DayWeatherViewState extends State<DayWeatherView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.sizeOf(context).width;

    return AnimatedBuilder(
    animation: animationController,
    builder: (context, child) {
      return Transform(
        transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.only(right: 5),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: SizedBox(
              height: 60,
              width: 60,
              child: Column(
                children: [
                  Text(
                    DateConverter.changeDtToDateTime(widget.day.dt),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  AppBackground.setIconForMain(
                    widget.day.weathers![0].description,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.day.main!.temp!.round()}${Constants.celsiusUniCode}",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1, curve: Curves.decelerate),
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
