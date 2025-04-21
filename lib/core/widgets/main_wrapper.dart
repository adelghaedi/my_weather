import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/weather/presentation/bloc/cw_status.dart';
import '../../feature/weather/presentation/bloc/weather_bloc.dart';


class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.cwStatus is CWLoading) {
            return Center(child: Text("Loading..."));
          }
          if (state.cwStatus is CWCompleted) {
            return Center(child: Text("Completed"));
          }
          if (state.cwStatus is CWError) {
            return Center(child: Text(("Error")));
          }

          return Container();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(LoadCWEvent(cityName: "Tehran"));
  }
}
