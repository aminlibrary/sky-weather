import 'package:flutter/material.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';

@immutable
abstract class CurrentCityWeatherStatus {}

class CurrentCityWeatherLoading extends CurrentCityWeatherStatus {}

class CurrentCityWeatherCompleted extends CurrentCityWeatherStatus {
  final CurrentCityWeatherEntity currentCityWeatherEntity;
  CurrentCityWeatherCompleted(this.currentCityWeatherEntity);
}

class CurrentCityWeatherError extends CurrentCityWeatherStatus {
  final String message;
  CurrentCityWeatherError(this.message);
}
