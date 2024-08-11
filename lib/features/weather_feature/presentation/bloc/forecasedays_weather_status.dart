import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather_feature/domain/entities/forecastdays_weather_entity.dart';

@immutable
abstract class ForecasedaysWeatherStatus extends Equatable {}

class ForecastdaysWeatherLoading extends ForecasedaysWeatherStatus {
  @override
  List<Object?> get props => [];
}

class ForecastdaysWeatherCompleted extends ForecasedaysWeatherStatus {
  final List<ForecastdaysWeatherEntity> forecastdaysWeatherEntity;
  ForecastdaysWeatherCompleted(this.forecastdaysWeatherEntity);

  @override
  List<Object?> get props => [forecastdaysWeatherEntity];
}

class ForecastdaysWeatherError extends ForecasedaysWeatherStatus {
  final String message;
  ForecastdaysWeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
