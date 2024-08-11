import 'package:dio/dio.dart';
import 'package:weather_app/core/params/forecastdays_weather_params.dart';
import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/features/weather_feature/data/data_source/remote/api_provider.dart';
import 'package:weather_app/features/weather_feature/data/models/city_name_suggection_model.dart';
import 'package:weather_app/features/weather_feature/data/models/current_city_weather_model.dart';
import 'package:weather_app/features/weather_feature/data/models/forecastdays_weather_model.dart';
import 'package:weather_app/features/weather_feature/domain/entities/city_name_suggection_entity.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';
import 'package:weather_app/features/weather_feature/domain/entities/forecastdays_weather_entity.dart';
import 'package:weather_app/features/weather_feature/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  ApiProvider apiProvider = ApiProvider();

  WeatherRepositoryImpl(this.apiProvider);

  //? current city weather
  @override
  Future<DataState<CurrentCityWeatherEntity>> fetchCurrentCityWeatherData(
      String cityName) async {
    //? try and catch
    try {
      //* call api
      final Response response =
          await apiProvider.callCurrentCityWeatherApi(cityName);

      //* status conditions
      switch (response.statusCode) {
        case 200:
          //* convert data
          final CurrentCityWeatherEntity currentCityWeatherEntity =
              CurrentCityWeatherModel.fromJson(response.data);

          //* return data
          return DataSuccess(currentCityWeatherEntity);

        default:
          //* handle error
          // debugPrint("error on status code - currentCity");

          //* return data
          return const DataFailed("Something went wrong!.");
      }
    } catch (e) {
      //* handle error
      // debugPrint("error on catch - currentCity - $e");

      //* return data
      return const DataFailed("Something went wrong!.");
    }
  }

  //? forecastdays weather
  @override
  Future<DataState<List<ForecastdaysWeatherEntity>>>
      fetchForecastdaysWeatherdata(ForecastdaysWeatherParams params) async {
    //? try & catch
    try {
      //* call api
      final Response response =
          await apiProvider.callForecastdaysWeatherApi(params);

      //* status conditions
      switch (response.statusCode) {
        case 200:
          //* convert data
          // ForecastdaysWeatherEntity forecastdaysWeatherEntity =
          //     ForecastdaysWeatherModel.fromJson(response.data);
          final List<ForecastdaysWeatherEntity> forecastdaysWeatherEntity = [];
          for (int i = 0; i < 16; i++) {
            final model = response.data["result"]["list"][i];

            final ForecastdaysWeatherModel forecastdaysWeatherModel =
                ForecastdaysWeatherModel(
                    main: model["weather"][0]["main"],
                    dt: model["dt"],
                    temp: model["temp"]["day"],
                    description: model["weather"][0]["description"],
                    icon: model["weather"][0]["icon"]);

            forecastdaysWeatherEntity.add(forecastdaysWeatherModel);
          }

          //* return data
          return DataSuccess(forecastdaysWeatherEntity);

        default:
          //* handle error
          // debugPrint("error on status code - forecast");

          //* return data
          return const DataFailed("Something went wrong!.");
      }
    } catch (e) {
      //* handle error
      // debugPrint("error on catch - forecast - $e");

      //* return data
      return const DataFailed("Something went wrong!.");
    }
  }

  //? city name suggection
  @override
  Future<List<Data>> fetchCityNameSuggectionData(String cityName) async {
    //* call api
    final Response response =
        await apiProvider.callCityNameSuggection(cityName);

    //* convert data
    final CityNameSuggectionEntity cityNameSuggectionEntity =
        CityNameSuggectionModel.fromJson(response.data);

    //* return data
    return cityNameSuggectionEntity.data!;
  }
}
