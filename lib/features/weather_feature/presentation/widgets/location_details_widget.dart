import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/date_converter.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';
import 'package:weather_app/core/widgets/txt.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';

class LocationDetailsWidget extends StatelessWidget {
  final CurrentCityWeatherEntity currentCityWeatherEntity;
  const LocationDetailsWidget(
      {required this.currentCityWeatherEntity, super.key});

  @override
  Widget build(BuildContext context) {
    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    return ContainerWidget(
        width: width * 0.576,
        height: height * 0.143,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* city name
              txt(
                currentCityWeatherEntity.name!,
                fontWeight: FontWeight.w700,
                size: width * 0.0625,
              ),

              //* weather description
              txt(
                currentCityWeatherEntity.weather![0].description!,
                size: width * 0.052,
              ),

              //* date time
              txt(
                DateConverter.changeDtToDateTimeHour(
                    currentCityWeatherEntity.dt,
                    currentCityWeatherEntity.timezone),
                fontWeight: FontWeight.w200,
                size: width * 0.047,
              )
            ],
          ),
        ));
  }
}
