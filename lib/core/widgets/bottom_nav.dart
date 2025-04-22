import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;

  const BottomNav({required this.pageController, super.key});

  @override
  Widget build(final BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    const double bottomAppBarHeight=63;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor,
      height: bottomAppBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_homeIcon(), const SizedBox(), _bookmarkIcon()],
      ),
    );
  }

  Widget _bookmarkIcon() =>
      IconButton(onPressed: _bookmarkIconOnPressed, icon: Icon(Icons.bookmark));

  void _bookmarkIconOnPressed() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _homeIcon() =>
      IconButton(onPressed: _homeIconOnPressed, icon: Icon(Icons.home));

  void _homeIconOnPressed() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
