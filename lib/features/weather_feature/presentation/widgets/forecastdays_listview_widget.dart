import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/params/forecastdays_weather_params.dart';
import 'package:weather_app/core/utils/date_converter.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';
import 'package:weather_app/core/widgets/loading_widget.dart';
import 'package:weather_app/core/widgets/txt.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';
import 'package:weather_app/features/weather_feature/domain/entities/forecastdays_weather_entity.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/forecasedays_weather_status.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';

class ForecastdaysListviewWidget extends StatelessWidget {
  final CurrentCityWeatherEntity currentCityWeatherEntity;
  const ForecastdaysListviewWidget(
      {required this.currentCityWeatherEntity, super.key});

  @override
  Widget build(BuildContext context) {
    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    //
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: SizedBox(
          width: double.infinity,
          height: height * 0.1865,
          child: BlocBuilder<WeatherBloc, WeatherState>(
              buildWhen: (previous, current) {
            if (previous.forecasedaysWeatherStatus ==
                current.forecasedaysWeatherStatus) {
              return false;
            } else {
              return true;
            }
          }, builder: (context, state) {
            if (state.forecasedaysWeatherStatus is ForecastdaysWeatherLoading) {
              return const Center(child: LoadingWidget());
            } else if (state.forecasedaysWeatherStatus
                is ForecastdaysWeatherError) {
              return Center(
                child: Column(
                  children: [
                    //* description
                    txt(
                      "something went wrong!.",
                      color: whiteColor,
                      size: width * 0.052,
                    ),

                    //* try again button
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: SizedBox(
                          width: width * 0.325,
                          height: height * 0.04975,
                          child: ElevatedButton(
                              onPressed: () {
                                //* set forecast days params
                                ForecastdaysWeatherParams
                                    forecastdaysWeatherParams =
                                    ForecastdaysWeatherParams(
                                  lat: currentCityWeatherEntity.coord!.lat,
                                  lon: currentCityWeatherEntity.coord!.lon,
                                );

                                //* call forecastdays weather api
                                BlocProvider.of<WeatherBloc>(context).add(
                                    LoadForecastdaysWeatherEvent(
                                        forecastdaysWeatherParams));
                              },
                              child: const txt(
                                "try again",
                                color: blackColor,
                              ))),
                    )
                  ],
                ),
              );
            } else if (state.forecasedaysWeatherStatus
                is ForecastdaysWeatherCompleted) {
              //* cast
              final ForecastdaysWeatherCompleted forecastdaysWeatherCompleted =
                  state.forecasedaysWeatherStatus
                      as ForecastdaysWeatherCompleted;

              //* forecastdays weather entity
              List<ForecastdaysWeatherEntity> forecastdaysWeatherEntity =
                  forecastdaysWeatherCompleted.forecastdaysWeatherEntity;

              //
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: forecastdaysWeatherEntity.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            //* date detail -- 10 jun --
                            txt(
                              DateConverter.changeDtToDateTime(
                                  forecastdaysWeatherEntity[index].dt),
                              color: whiteColor,
                            ),

                            //* weather detail
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: ContainerWidget(
                                  width: width * 0.26,
                                  height: height * 0.155,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //* date time
                                      txt("${DateConverter.changeDtToDateTimeDays(forecastdaysWeatherEntity[index].dt)}, ${DateConverter.changeDtToDateTimeHour(currentCityWeatherEntity.timezone, forecastdaysWeatherEntity[index].dt)}"),

                                      //* weather icon
                                      CachedNetworkImage(
                                        imageUrl:
                                            "https://openweathermap.org/img/wn/${forecastdaysWeatherEntity[index].icon}@2x.png",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              color: blueColor,
                                              value: downloadProgress.progress),
                                        ),
                                        width: width * 0.15625,
                                        height: height * 0.0745,
                                      ),

                                      //* temp
                                      txt(
                                        "${forecastdaysWeatherEntity[index].temp!.round()}\u00B0",
                                        size: width * 0.052,
                                        fontWeight: FontWeight.w700,
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ));
                  });
            } else {
              return const SizedBox();
            }
          })),
    );
  }
}
