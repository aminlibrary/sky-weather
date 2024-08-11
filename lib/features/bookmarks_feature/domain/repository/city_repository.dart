import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/features/bookmarks_feature/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<DataState<CityEntity>> saveCityToDB(String cityName);

  Future<DataState<List<CityEntity>>> getAllCityFromDB();

  Future<DataState<CityEntity?>> findCityByName(String name);

  Future<DataState<String>> deleteCityByName(String name);
}
