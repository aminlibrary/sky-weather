part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

//? load current city weather event
class LoadCurrentCityWeatherEvent extends WeatherEvent {
  final String cityName;
  const LoadCurrentCityWeatherEvent(this.cityName);
}

//? load forecastdays weather event
class LoadForecastdaysWeatherEvent extends WeatherEvent {
  final ForecastdaysWeatherParams params;
  const LoadForecastdaysWeatherEvent(this.params);
}
