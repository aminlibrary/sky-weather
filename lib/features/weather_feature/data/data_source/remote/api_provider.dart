import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/urls.dart';
import 'package:weather_app/core/params/forecastdays_weather_params.dart';

class ApiProvider {
  //? current city weather api call
  Future<dynamic> callCurrentCityWeatherApi(String cityName) async {
    //* api key
    String apiKey = openWeatherApiKey;

    //* api url
    String apiUrl = openWeatherApiUrl;

    //* send request to api
    Response response = await Dio().get(apiUrl,
        queryParameters: {"q": cityName, "appid": apiKey, "units": "metric"});

    //* return data
    return response;
  }

  //? forecastdays weather api call
  Future<dynamic> callForecastdaysWeatherApi(
      ForecastdaysWeatherParams params) async {
    //* api key
    String apiKey = oneServiceApiKey;

    //* api url
    String apiUrl = oneServiceApiUrl;

    //* send request to api
    Response response = await Dio().get(apiUrl, queryParameters: {
      "token": apiKey,
      "action": "dailybylocation",
      "lon": params.lon,
      "lat": params.lat
    });

    //* return data
    return response;
  }

  //? city name suggection api call
  Future<dynamic> callCityNameSuggection(String prefix) async {
    //* send request to api
    var response = await Dio().get(
        "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
        queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix});

    //* return data
    return response;
  }
}
