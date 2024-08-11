import 'package:weather_app/core/params/forecastdays_weather_params.dart';
import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/features/weather_feature/data/models/city_name_suggection_model.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';
import 'package:weather_app/features/weather_feature/domain/entities/forecastdays_weather_entity.dart';

abstract class WeatherRepository {
  //? fetch current city weather data
  Future<DataState<CurrentCityWeatherEntity>> fetchCurrentCityWeatherData(
      String cityName);

  //? fetch forecastdays weather data
  Future<DataState<List<ForecastdaysWeatherEntity>>>
      fetchForecastdaysWeatherdata(ForecastdaysWeatherParams params);

  //? fetch city name suggection data
  Future<List<Data>> fetchCityNameSuggectionData(String cityName);
}
