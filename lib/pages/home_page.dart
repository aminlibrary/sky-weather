import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/models/forecast_days_model.dart';
import 'package:weather_app/widgets/txt.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static bool permission = false;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //? futures :
  late Future<CurrentWeatherModel> currentWeatherModel;

  //? streams :
  late StreamController<List<ForecastDaysModel>> forcastDaysStream;
  late StreamController<CurrentWeatherModel> currentWeatherStream;

  //? controllers :
  TextEditingController cityNameController = TextEditingController();

  //? variables
  bool onLoading = true;
  final box = MyApp.box;

  //
  @override
  void initState() {
    //* call the api
    //currentWeatherModel = sendRequestCurrentWeather("tabriz");

    currentWeatherStream = StreamController<CurrentWeatherModel>();
    forcastDaysStream = StreamController<List<ForecastDaysModel>>();
    sendRequestCurrentWeather("tabriz", currentWeatherStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //* call api
    checkPermission();

    //* read data
    box.read("isSent") == true ? null : sendAppUsers(box);

    //
    return Scaffold(
        //? appbar of page
        appBar: AppBar(
          title: const txt(
            "Weather app",
            color: Colors.white,
          ),
          actions: [
            PopupMenuButton<String>(
                icon: const Icon(Icons.menu_rounded),
                iconColor: Colors.white,
                itemBuilder: (context) {
                  return {
                    "settings",
                    "logout",
                    "about me",
                  }.map((String choice) {
                    return PopupMenuItem(
                        value: choice,
                        child: txt(
                          choice,
                          color: Colors.black,
                        ));
                  }).toList();
                })
          ],
          backgroundColor: const Color(0xFF181818),
          elevation: 0,
        ),

        //? body of page
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF181818),
            child: SingleChildScrollView(
              child: Column(children: [
                //? search bar
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      //* find button to search location
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              sendRequestCurrentWeather(cityNameController.text,
                                  currentWeatherStream);
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const txt(
                            "Find",
                            color: Colors.black,
                          )),

                      //* location name to search
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: cityNameController,
                          enableInteractiveSelection: false,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "City or location name:",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),

                //? weather
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 550,
                      child: StreamBuilder<CurrentWeatherModel>(
                          stream: currentWeatherStream.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              //* variables
                              CurrentWeatherModel? currentDataModel =
                                  snapshot.data;

                              //* call api
                              HomePage.permission == true
                                  ? sendRequestForecastDaysWeather(
                                      currentDataModel!.lat.toString(),
                                      currentDataModel.lon.toString(),
                                      forcastDaysStream)
                                  : null;

                              //* coverting
                              final formatter = DateFormat.jm();
                              // sunrise
                              var sunrise = formatter.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      currentDataModel!.sunrise * 1000,
                                      isUtc: true));
                              // sunset
                              var sunset = formatter.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      currentDataModel.sunset * 1000,
                                      isUtc: true));

                              //? app data
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //? city name
                                  txt(
                                    currentDataModel.cityName,
                                    size: 30,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  //? weather description
                                  txt(
                                    currentDataModel.description,
                                    size: 20,
                                  ),

                                  //? weather icon
                                  Icon(
                                    setMainIcon(currentDataModel),
                                    size: 100,
                                    color: Colors.white,
                                  ),

                                  //? weather temp
                                  txt(
                                    "${currentDataModel.temp.round().toString()}\u00B0",
                                    size: 40,
                                  ),

                                  //? min and max temperature
                                  SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //* minimum temp
                                        detailsOfWeather(
                                            "Min",
                                            currentDataModel.tempMin
                                                .round()
                                                .toString(),
                                            false),

                                        // divider
                                        const SizedBox(
                                          width: 1,
                                          height: 25,
                                          child: ColoredBox(color: Colors.grey),
                                        ),

                                        //* maximum temp
                                        detailsOfWeather(
                                            "Max",
                                            currentDataModel.tempMax
                                                .round()
                                                .toString(),
                                            false),
                                      ],
                                    ),
                                  ),

                                  //? 16-ten days weather temp
                                  SizedBox(
                                    width: double.infinity,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        // divider
                                        const SizedBox(
                                          width: double.infinity,
                                          height: 1,
                                          child: ColoredBox(color: Colors.grey),
                                        ),

                                        //* list of days
                                        Expanded(
                                            child: StreamBuilder<
                                                List<ForecastDaysModel>>(
                                          stream: forcastDaysStream.stream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              //* variables
                                              List<ForecastDaysModel>?
                                                  forecastDataModel =
                                                  snapshot.data;

                                              //
                                              return ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 10,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return sixTeenDaysWeather(
                                                        forecastDataModel![
                                                            index + 1]);
                                                  });
                                            } else {
                                              return const SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeCap: StrokeCap.round,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        )),

                                        // divider
                                        const SizedBox(
                                          width: double.infinity,
                                          height: 1,
                                          child: ColoredBox(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //? other details of weather
                                  SizedBox(
                                    width: 300,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //* wind speed
                                        detailsOfWeather(
                                            "wind speed",
                                            "${currentDataModel.windSpeed.toString()} m/s",
                                            true),

                                        // divider
                                        const SizedBox(
                                          width: 1,
                                          height: 25,
                                          child: ColoredBox(color: Colors.grey),
                                        ),

                                        //* sunrise
                                        detailsOfWeather(
                                            "sunrise", sunrise, true),

                                        // divider
                                        const SizedBox(
                                          width: 1,
                                          height: 25,
                                          child: ColoredBox(color: Colors.grey),
                                        ),

                                        //* sunset
                                        detailsOfWeather(
                                            "sunset", sunset, true),

                                        // divider
                                        const SizedBox(
                                          width: 1,
                                          height: 25,
                                          child: ColoredBox(color: Colors.grey),
                                        ),

                                        //* humidity
                                        detailsOfWeather(
                                            "humidity",
                                            "${currentDataModel.humidity.toString()}%",
                                            true),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else {
                              //? progress indicator
                              return const SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  ));
                            }
                          })),
                )
              ]),
            )));
  }
}

//? minimum and maximum temperature widget function
Column detailsOfWeather(String title, String detail, bool isSmallWidget) {
  return Column(
    children: [
      // title
      txt(
        title,
        size: isSmallWidget == true ? 14 : 20,
        color: Colors.grey,
      ),

      // temp
      txt(
        detail,
        size: isSmallWidget == true ? 14 : 18,
        color: Colors.white,
      ),
    ],
  );
}

//? 16-ten days weather widget
Padding sixTeenDaysWeather(ForecastDaysModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //* day name
          txt(
            model.dataTime,
            color: Colors.white,
          ),

          //* weather icon
          Icon(
            setMainIcon(model),
            color: Colors.white,
            size: 40,
          ),

          //* temp
          txt(
            "${model.temp.round().toString()}\u00B0",
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}

//? send request to weather api and get data ( open weather map api )
void sendRequestCurrentWeather(
    String? cityName, StreamController<CurrentWeatherModel> stream) async {
  //* variables
  String apiKey = "154aa0eb6c0386bbc16c98c09bf0fccc";

  Response response;

  //* send request to api
  try {
    response = await Dio().get(
        "https://api.openweathermap.org/data/2.5/weather",
        queryParameters: {"q": cityName!, "appid": apiKey, "units": "metric"});
  } catch (e) {
    response = await Dio().get(
        "https://api.openweathermap.org/data/2.5/weather",
        queryParameters: {"q": "tabriz", "appid": apiKey, "units": "metric"});
  }

  //* show request data details
  // ignore: avoid_print
  print(response.data);
  // ignore: avoid_print
  print(response.statusCode);

  var dataModel = CurrentWeatherModel(
      response.data["name"],
      response.data["coord"]["lon"],
      response.data["coord"]["lat"],
      response.data["weather"][0]["main"],
      response.data["weather"][0]["description"],
      response.data["main"]["temp"],
      response.data["main"]["temp_min"],
      response.data["main"]["temp_max"],
      response.data["main"]["pressure"],
      response.data["main"]["humidity"],
      response.data["wind"]["speed"],
      response.data["dt"],
      response.data["sys"]["country"],
      response.data["sys"]["sunrise"],
      response.data["sys"]["sunset"]);

  stream.add(dataModel);
  // notes: i did not write full api address on response, because i fill the parameters with ( queryParameters ).
}

//? send request to weather api and get forecast days data ( one service )
void sendRequestForecastDaysWeather(
    lat, lon, StreamController<List<ForecastDaysModel>> stream) async {
  List<ForecastDaysModel> list = [];
  String apiKey = "447990:6673facaaa8b3";

  Response response = await Dio().get("https://one-api.ir/weather",
      queryParameters: {
        "token": apiKey,
        "action": "monthbylocation",
        "lat": lat,
        "lon": lon
      });

  final formmater = DateFormat.MMMd();

  for (int i = 0; i < 17; i++) {
    var model = response.data["result"]["list"][i];

    var dt = formmater.format(
        DateTime.fromMillisecondsSinceEpoch(model["dt"] * 1000, isUtc: true));

    ForecastDaysModel forecastDaysModel = ForecastDaysModel(
        model["weather"][0]["main"],
        dt,
        model["temp"]["day"],
        model["weather"][0]["description"]);

    list.add(forecastDaysModel);
  }

  stream.add(list);

  // ignore: avoid_print
  print(response.data);
  // ignore: avoid_print
  print(response.statusCode);
}

//? send app users ( how much people using this app - not them data )
void sendAppUsers(box) async {
  Dio().post("https://retoolapi.dev/daqwvT/aminlibrary-weatherapp",
      data: {"permission": false});

  box.write("isSent", true);
}

//? check forecast days api permission
void checkPermission() async {
  Response response =
      await Dio().get("https://retoolapi.dev/daqwvT/aminlibrary-weatherapp");
  HomePage.permission = response.data[0]["permission"];
}

//? set weather icon for main
IconData setMainIcon(model) {
  var main = model.main;

  //* switch for description data
  switch (main) {
    case "Clear":
      return CupertinoIcons.sun_max;
    case "Clouds":
      return CupertinoIcons.cloud_sun;
    case "Thunderstorm":
      return CupertinoIcons.tornado;
    case "Drizzle":
      return CupertinoIcons.cloud_sun_rain;
    case "Rain":
      return CupertinoIcons.cloud_rain;
    case "Snow":
      return CupertinoIcons.cloud_snow;
    case "Atmosphere":
      return CupertinoIcons.wind;
    default:
      return CupertinoIcons.wifi_slash;
  }
}
