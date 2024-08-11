import 'package:equatable/equatable.dart';
import 'package:weather_app/features/bookmarks_feature/domain/entities/city_entity.dart';

abstract class GetAllCityStatus extends Equatable {}

// loading state
class GetAllCityLoading extends GetAllCityStatus {
  @override
  List<Object?> get props => [];
}

// loaded state
class GetAllCityCompleted extends GetAllCityStatus {
  final List<CityEntity> cities;
  GetAllCityCompleted(this.cities);

  @override
  List<Object?> get props => [cities];
}

// error state
class GetAllCityError extends GetAllCityStatus {
  final String? message;
  GetAllCityError(this.message);

  @override
  List<Object?> get props => [message];
}
