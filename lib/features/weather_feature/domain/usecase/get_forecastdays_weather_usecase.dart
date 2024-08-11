import 'package:weather_app/core/params/forecastdays_weather_params.dart';
import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather_feature/domain/entities/forecastdays_weather_entity.dart';
import 'package:weather_app/features/weather_feature/domain/repository/weather_repository.dart';

class GetForecastdaysWeatherUsecase
    implements
        Usecase<DataState<List<ForecastdaysWeatherEntity>>,
            ForecastdaysWeatherParams> {
  final WeatherRepository weatherRepository;
  GetForecastdaysWeatherUsecase(this.weatherRepository);

  @override
  Future<DataState<List<ForecastdaysWeatherEntity>>> call(
      ForecastdaysWeatherParams params) {
    return weatherRepository.fetchForecastdaysWeatherdata(params);
  }
}
