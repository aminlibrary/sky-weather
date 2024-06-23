// ignore_for_file: prefer_typing_uninitialized_variables

class CurrentWeatherModel {
  final String? _cityName;
  final _lon;
  final _lat;
  final String? _main;
  final String? _description;
  final _temp;
  final _tempMin;
  final _tempMax;
  final _pressure;
  final _humidity;
  final _windSpeed;
  final _dataTime;
  final String? _country;
  final _sunrise;
  final _sunset;

  CurrentWeatherModel(
    this._cityName,
    this._lon,
    this._lat,
    this._main,
    this._description,
    this._temp,
    this._tempMin,
    this._tempMax,
    this._pressure,
    this._humidity,
    this._windSpeed,
    this._dataTime,
    this._country,
    this._sunrise,
    this._sunset,
  );

  get cityName => _cityName;
  get lon => _lon;
  get lat => _lat;
  get main => _main;
  get description => _description;
  get temp => _temp;
  get tempMax => _tempMax;
  get tempMin => _tempMin;
  get pressure => _pressure;
  get humidity => _humidity;
  get windSpeed => _windSpeed;
  get dataTime => _dataTime;
  get country => _country;
  get sunrise => _sunrise;
  get sunset => _sunset;
}
