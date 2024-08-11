import 'package:weather_app/features/weather_feature/domain/entities/forecastdays_weather_entity.dart';

class ForecastdaysWeatherModel extends ForecastdaysWeatherEntity {
  const ForecastdaysWeatherModel(
      {super.main, super.dt, super.temp, super.description, super.icon});

  factory ForecastdaysWeatherModel.fromJson(Map<String, dynamic> json) {
    return ForecastdaysWeatherModel(
      main: json['main'],
      dt: json['dt'],
      temp: json['temp'],
      description: json['description'],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['main'] = main;
    data['dt'] = dt;
    data['temp'] = temp;
    data['description'] = description;
    data["icon"] = icon;
    return data;
  }
}
