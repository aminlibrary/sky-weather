part of 'weather_bloc.dart';

class WeatherState {
  CurrentCityWeatherStatus currentCityWeatherStatus;
  ForecasedaysWeatherStatus forecasedaysWeatherStatus;
  WeatherState(
      {required this.currentCityWeatherStatus,
      required this.forecasedaysWeatherStatus});

  WeatherState copyWith(
      {CurrentCityWeatherStatus? newCurrentCityWeatherStatus,
      ForecasedaysWeatherStatus? newForecastdaysWeatherStatus}) {
    return WeatherState(
        currentCityWeatherStatus:
            newCurrentCityWeatherStatus ?? currentCityWeatherStatus,
        forecasedaysWeatherStatus:
            newForecastdaysWeatherStatus ?? forecasedaysWeatherStatus);
  }
}
