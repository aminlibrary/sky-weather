import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';
import 'package:weather_app/core/widgets/txt.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final CurrentCityWeatherEntity currentCityWeatherEntity;
  const WeatherDetailsWidget(
      {required this.currentCityWeatherEntity, super.key});

  @override
  Widget build(BuildContext context) {
    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    //
    return ContainerWidget(
        width: width * 0.306,
        height: height * 0.267,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //* weather icon
            CachedNetworkImage(
              imageUrl:
                  "https://openweathermap.org/img/wn/${currentCityWeatherEntity.weather![0].icon!}@2x.png",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                    color: blueColor, value: downloadProgress.progress),
              ),
              width: width * 0.195,
              height: height * 0.0931,
            ),

            //* weather main
            Column(
              children: [
                txt(
                  currentCityWeatherEntity.weather![0].main!,
                  fontWeight: FontWeight.w500,
                  size: width * 0.052,
                ),

                //* temp
                txt(
                  "${currentCityWeatherEntity.main!.temp!.round()}\u00B0",
                  fontWeight: FontWeight.w700,
                  size: width * 0.073,
                ),
              ],
            )
          ],
        ));
  }
}
