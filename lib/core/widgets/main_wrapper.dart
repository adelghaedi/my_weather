import 'package:flutter/material.dart';

import '../../feature/bookmark/presentation/pages/bookmark_page.dart';
import '../../feature/weather/presentation/pages/weather_page.dart';
import 'app_background.dart';
import 'bottom_nav.dart';

class MainWrapper extends StatelessWidget {
  final PageController pageController = PageController(initialPage: 0);

  MainWrapper({super.key});

  @override
  Widget build(final BuildContext context) {

    const List<Widget> pages = [ WeatherPage(), BookmarkPage()];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(pageController: pageController),
      body: _body(pages),
    );
  }

  Widget _body(List<Widget> pages) => Container(
      decoration: _decoration(),
      child: PageView(controller: pageController, children: pages),
    );

  BoxDecoration _decoration() => BoxDecoration(
      image: DecorationImage(
        image: AppBackground.getBackgroundImage(),
        fit: BoxFit.cover,
      ),
    );
}
