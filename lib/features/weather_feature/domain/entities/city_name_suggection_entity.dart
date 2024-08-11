import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_feature/data/models/city_name_suggection_model.dart';

class CityNameSuggectionEntity extends Equatable {
  final List<Data>? data;
  final Metadata? metadata;

  const CityNameSuggectionEntity({this.data, this.metadata});

  @override
  List<Object?> get props => [
        data,
        metadata,
      ];

  @override
  bool? get stringify => true;
}
