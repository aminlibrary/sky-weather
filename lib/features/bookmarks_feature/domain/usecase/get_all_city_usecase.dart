import 'package:weather_app/core/params/no_params.dart';
import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/bookmarks_feature/domain/entities/city_entity.dart';
import 'package:weather_app/features/bookmarks_feature/domain/repository/city_repository.dart';

class GetAllCityUseCase
    implements Usecase<DataState<List<CityEntity>>, NoParams> {
  final CityRepository _cityRepository;
  GetAllCityUseCase(this._cityRepository);

  @override
  Future<DataState<List<CityEntity>>> call(NoParams params) {
    return _cityRepository.getAllCityFromDB();
  }
}
