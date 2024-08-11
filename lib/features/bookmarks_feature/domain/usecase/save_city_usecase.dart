import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/bookmarks_feature/domain/entities/city_entity.dart';
import 'package:weather_app/features/bookmarks_feature/domain/repository/city_repository.dart';

class SaveCityUseCase implements Usecase<DataState<CityEntity>, String> {
  final CityRepository _cityRepository;
  SaveCityUseCase(this._cityRepository);

  @override
  Future<DataState<CityEntity>> call(String params) {
    return _cityRepository.saveCityToDB(params);
  }
}
