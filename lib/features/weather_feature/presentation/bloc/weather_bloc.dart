import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/params/forecastdays_weather_params.dart';
import 'package:weather_app/core/resource/data_state.dart';
import 'package:weather_app/features/weather_feature/domain/usecase/get_current_city_weather_usecase.dart';
import 'package:weather_app/features/weather_feature/domain/usecase/get_forecastdays_weather_usecase.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/current_city_weather_status.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/forecasedays_weather_status.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentCityWeatherUsecase getCurrentCityWeatherUsecase;
  final GetForecastdaysWeatherUsecase getForecastdaysWeatherUsecase;

  WeatherBloc(
      this.getCurrentCityWeatherUsecase, this.getForecastdaysWeatherUsecase)
      : super(WeatherState(
            currentCityWeatherStatus: CurrentCityWeatherLoading(),
            forecasedaysWeatherStatus: ForecastdaysWeatherLoading())) {
    //? weather event
    on<WeatherEvent>((event, emit) {});

    //? current city weather event
    on<LoadCurrentCityWeatherEvent>((event, emit) async {
      //* set state on loading
      emit(state.copyWith(
          newCurrentCityWeatherStatus: CurrentCityWeatherLoading()));

      //* call current city weather api
      final DataState dataState =
          await getCurrentCityWeatherUsecase(event.cityName);

      //* data state conditions
      if (dataState is DataSuccess) {
        //* convert data

        emit(
          state.copyWith(
            newCurrentCityWeatherStatus:
                CurrentCityWeatherCompleted(dataState.data),
          ),
        );
      } else if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newCurrentCityWeatherStatus:
                CurrentCityWeatherError(dataState.error!),
          ),
        );
      } else {}
    });

    //? forecastdays weather event
    on<LoadForecastdaysWeatherEvent>((event, emit) async {
      //* set state on loading
      emit(
        state.copyWith(
          newForecastdaysWeatherStatus: ForecastdaysWeatherLoading(),
        ),
      );

      //* call forecastdays weather api
      final DataState dataState =
          await getForecastdaysWeatherUsecase(event.params);

      //* data state conditions
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newForecastdaysWeatherStatus:
                ForecastdaysWeatherCompleted(dataState.data),
          ),
        );
      } else if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newForecastdaysWeatherStatus:
                ForecastdaysWeatherError(dataState.error!),
          ),
        );
      } else {}
    });
  }
}
