import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/constants/controllers.dart';
import 'package:weather_app/core/providers/bottom_nav_provider.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    //* provider
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    //
    return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: ContainerWidget(
          width: width * 0.65,
          height: height * 0.093,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //* home icon
                IconButton(
                  onPressed: () {
                    //* push home page
                    Controllers.pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease);

                    //* update state
                    bottomNavProvider.toggleIndex(0);
                  },
                  icon: Icon(
                    bottomNavProvider.index == 0
                        ? CupertinoIcons.house_alt_fill
                        : CupertinoIcons.house_alt,
                    size: width * 0.078125,
                  ),
                ),

                //* bookmarks icon
                IconButton(
                  onPressed: () {
                    //* push bookmarks page
                    Controllers.pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);

                    //* update state
                    bottomNavProvider.toggleIndex(1);
                  },
                  icon: Icon(
                    bottomNavProvider.index == 0
                        ? CupertinoIcons.bookmark
                        : CupertinoIcons.bookmark_fill,
                    size: width * 0.078125,
                  ),
                ),

                // //* search icon
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       CupertinoIcons.search,
                //       size: 30,
                //     )),
              ],
            ),
          ),
        ));
  }
}
