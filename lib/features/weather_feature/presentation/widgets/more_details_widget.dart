import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/txt.dart';

class MoreDetailsWidget extends StatelessWidget {
  final String title;
  final String detail;
  const MoreDetailsWidget(
      {required this.title, required this.detail, super.key});

  @override
  Widget build(BuildContext context) {
    //* variables
    final width = ScreenUtils(context).width;

    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //* title
        txt(
          title,
          size: width * 0.046875,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        ),

        //* detail
        txt(
          detail,
          size: width * 0.03645,
          fontWeight: FontWeight.w500,
          color: whiteColor,
        )
      ],
    );
  }
}
