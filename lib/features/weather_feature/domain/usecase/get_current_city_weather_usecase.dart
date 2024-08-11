import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather_feature/domain/entities/current_city_weather_entity.dart';
import 'package:weather_app/features/weather_feature/domain/repository/weather_repository.dart';

class GetCurrentCityWeatherUsecase
    implements Usecase<DataState<CurrentCityWeatherEntity>, String> {
  final WeatherRepository weatherRepository;
  GetCurrentCityWeatherUsecase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityWeatherEntity>> call(String params) {
    return weatherRepository.fetchCurrentCityWeatherData(params);
  }
}
