import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/constants/controllers.dart';
import 'package:weather_app/core/widgets/bottom_nav.dart';
import 'package:weather_app/features/bookmarks_feature/presentation/pages/bookmarks_page.dart';
import 'package:weather_app/features/weather_feature/presentation/pages/home_page.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //* page view pages list
    List<Widget> pages = const <Widget>[HomePage(), BookmarksPage()];

    // root
    return SafeArea(
      child: Scaffold(
        //* body of page
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: blueColor,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //* page view
              PageView(
                controller: Controllers.pageController,
                children: pages,
              ),

              //* bottom nav bar

              const BottomNav(),
            ],
          ),
        ),
      ),
    );
  }
}
