import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather_feature/data/models/city_name_suggection_model.dart';
import 'package:weather_app/features/weather_feature/domain/repository/weather_repository.dart';

class GetCityNameSuggectionUsecase implements Usecase<List<Data>, String> {
  final WeatherRepository weatherRepository;
  GetCityNameSuggectionUsecase(this.weatherRepository);

  @override
  Future<List<Data>> call(String params) {
    return weatherRepository.fetchCityNameSuggectionData(params);
  }
}
