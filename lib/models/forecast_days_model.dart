// ignore_for_file: prefer_typing_uninitialized_variables

class ForecastDaysModel {
  final _main;
  final _dataTime;
  final _temp;
  final _description;

  ForecastDaysModel(
    this._main,
    this._dataTime,
    this._temp,
    this._description,
  );

  get main => _main;
  get dataTime => _dataTime;
  get temp => _temp;
  get description => _description;
}
