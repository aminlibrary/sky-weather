import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/core/constants/colors.dart';
import 'package:weather_app/core/constants/controllers.dart';
import 'package:weather_app/core/params/forecastdays_weather_params.dart';
import 'package:weather_app/core/utils/date_converter.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';
import 'package:weather_app/core/widgets/loading_widget.dart';
import 'package:weather_app/core/widgets/txt.dart';
import 'package:weather_app/features/bookmarks_feature/presentation/bloc/bookmark_bloc.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/current_city_weather_status.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/bookmarks_icon.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/forecastdays_listview_widget.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/location_details_widget.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/min_max_temp_widget.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/more_details_widget.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/popupmenu_widget.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/search_bar_widget.dart';
import 'package:weather_app/features/weather_feature/presentation/widgets/weather_details_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //? get storage box
  static final box = GetStorage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    //* call current city weather api
    BlocProvider.of<WeatherBloc>(context).add(
        LoadCurrentCityWeatherEvent(HomePage.box.read("city") ?? "tabriz"));
  }

  @override
  Widget build(BuildContext context) {
    //
    super.build(context);

    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    print("width: $width, height: $height");
    //width: 384.0, height: 805.3333333333334

    // page
    return SingleChildScrollView(
      child: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          buildWhen: (pervious, current) {
            //? if current city weather state do not changed, don't build again.
            if (pervious.currentCityWeatherStatus ==
                current.currentCityWeatherStatus) {
              return false;
            } else {
              return true;
            }
          },
          builder: (context, state) {
            if (state.currentCityWeatherStatus is CurrentCityWeatherLoading) {
              return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: const Center(child: LoadingWidget()));
            } else if (state.currentCityWeatherStatus
                is CurrentCityWeatherError) {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* description
                    const txt(
                      "Something went wrong!.\nPlease search city name.",
                      color: whiteColor,
                      size: 20,
                      textAlign: TextAlign.center,
                    ),

                    //* search bar
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SearchBarWidget(),
                    ),

                    //* find button
                    SizedBox(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              //* call current city weather api
                              BlocProvider.of<WeatherBloc>(context).add(
                                  LoadCurrentCityWeatherEvent(
                                      Controllers.textEditingController.text));

                              //* save city name in memory
                              HomePage.box.write("city",
                                  Controllers.textEditingController.text);
                            },
                            child: const txt(
                              "find",
                              color: blackColor,
                            )))
                  ],
                ),
              );
            } else if (state.currentCityWeatherStatus
                is CurrentCityWeatherCompleted) {
              //* cast
              final CurrentCityWeatherCompleted currentCityWeatherCompleted =
                  state.currentCityWeatherStatus as CurrentCityWeatherCompleted;

              //* current city weather entity
              CurrentCityWeatherEntity currentCityWeatherEntity =
                  currentCityWeatherCompleted.currentCityWeatherEntity;

              //* set forecast days params
              ForecastdaysWeatherParams forecastdaysWeatherParams =
                  ForecastdaysWeatherParams(
                lat: currentCityWeatherEntity.coord!.lat,
                lon: currentCityWeatherEntity.coord!.lon,
              );

              //* call forecastdays weather api
              BlocProvider.of<WeatherBloc>(context)
                  .add(LoadForecastdaysWeatherEvent(forecastdaysWeatherParams));

              //
              BlocProvider.of<BookmarkBloc>(context).add(GetCityByNameEvent(
                  currentCityWeatherCompleted.currentCityWeatherEntity.name!));

              //* return widgets
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* title
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25.0, left: 15.0, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //* name
                        txt(
                          "Sky Weather",
                          color: whiteColor,
                          size: width * 0.078125,
                          fontWeight: FontWeight.w700,
                        ),

                        //* popup menu
                        const PopupmenuWidget(),
                      ],
                    ),
                  ),

                  //* search bar
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 15),
                      child: Row(
                        children: [
                          //* search bar
                          const Expanded(child: SearchBarWidget()),

                          //* bookmarks icon
                          BookMarkIcon(
                              name: currentCityWeatherCompleted
                                  .currentCityWeatherEntity.name!)
                        ],
                      )),

                  //
                  SizedBox(
                    height: height * 0.267,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //* location details
                              LocationDetailsWidget(
                                  currentCityWeatherEntity:
                                      currentCityWeatherEntity),

                              //* min & max temp
                              MinMaxTempWidget(
                                  currentCityWeatherEntity:
                                      currentCityWeatherEntity),
                            ],
                          ),

                          //* weather icon & temp
                          WeatherDetailsWidget(
                              currentCityWeatherEntity:
                                  currentCityWeatherEntity),
                        ],
                      ),
                    ),
                  ),

                  //* list view - forecast days weather
                  ForecastdaysListviewWidget(
                      currentCityWeatherEntity: currentCityWeatherEntity),

                  //* more details
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 15.0, right: 15),
                    child: ContainerWidget(
                        width: double.infinity,
                        height: height * 0.124,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //* wind speed
                            MoreDetailsWidget(
                                title: "wind",
                                detail:
                                    "${currentCityWeatherEntity.wind!.speed} m/s"),

                            //* divider
                            Container(
                              width: width * 0.0026,
                              height: height * 0.0435,
                              color: whiteColor,
                            ),

                            //* sunrise
                            MoreDetailsWidget(
                                title: "sunset",
                                detail: DateConverter.changeDtToDateTimeHour(
                                    currentCityWeatherEntity.sys!.sunset,
                                    currentCityWeatherEntity.timezone)),

                            //* divider
                            Container(
                              width: width * 0.0026,
                              height: height * 0.0435,
                              color: whiteColor,
                            ),

                            //* sunset
                            MoreDetailsWidget(
                                title: "sunrise",
                                detail: DateConverter.changeDtToDateTimeHour(
                                    currentCityWeatherEntity.sys!.sunrise,
                                    currentCityWeatherEntity.timezone)),

                            //* divider
                            Container(
                              width: width * 0.0026,
                              height: height * 0.0435,
                              color: whiteColor,
                            ),

                            //* humidity
                            MoreDetailsWidget(
                                title: "humidity",
                                detail:
                                    "${currentCityWeatherEntity.main!.humidity}%")
                          ],
                        )),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
