import 'package:floor/floor.dart';
import 'package:weather_app/features/bookmarks_feature/domain/entities/city_entity.dart';

@dao
abstract class CityDao {
  @Query('SELECT * FROM City')
  Future<List<CityEntity>> getAllCity();

  @Query('SELECT * FROM City WHERE name = :name')
  Future<CityEntity?> findCityByName(String name);

  @insert
  Future<void> insertCity(CityEntity city);

  @Query('DELETE FROM City WHERE name = :name')
  Future<void> deleteCityByName(String name);
}