import 'package:equatable/equatable.dart';

class ForecastdaysWeatherEntity extends Equatable {
  final String? main;
  final int? dt;
  final double? temp;
  final String? description;
  final String? icon;

  const ForecastdaysWeatherEntity(
      {this.main, this.dt, this.temp, this.description, this.icon});

  @override
  List<Object?> get props => [main, dt, temp, description, icon];
}
