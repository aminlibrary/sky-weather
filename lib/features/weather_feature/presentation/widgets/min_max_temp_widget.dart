import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';
import 'package:weather_app/core/widgets/txt.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';

class MinMaxTempWidget extends StatelessWidget {
  final CurrentCityWeatherEntity currentCityWeatherEntity;
  const MinMaxTempWidget({required this.currentCityWeatherEntity, super.key});

  @override
  Widget build(BuildContext context) {
    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    //
    return ContainerWidget(
        width: width * 0.576,
        height: height * 0.087,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* min temp
              Column(
                children: [
                  //* title
                  txt(
                    "Min",
                    size: width * 0.052,
                    fontWeight: FontWeight.w500,
                  ),

                  //* temp
                  txt(
                    "${currentCityWeatherEntity.main!.tempMin!.round()}\u00B0",
                    size: width * 0.052,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),

              //* divider
              Container(
                width: width * 0.0026,
                height: height * 0.0435,
                color: blackColor,
              ),

              //* min temp
              Column(
                children: [
                  //* title
                  txt(
                    "Max",
                    size: width * 0.052,
                    fontWeight: FontWeight.w500,
                  ),

                  //* temp
                  txt(
                    "${currentCityWeatherEntity.main!.tempMax!.round()}\u00B0",
                    size: width * 0.052,
                    fontWeight: FontWeight.w700,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
