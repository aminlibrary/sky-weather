import 'package:get_it/get_it.dart';
import 'package:weather_app/features/bookmarks_feature/data/data_source/local/database.dart';
import 'package:weather_app/features/bookmarks_feature/data/repository/city_repository_impl.dart';
import 'package:weather_app/features/bookmarks_feature/domain/repository/city_repository.dart';
import 'package:weather_app/features/bookmarks_feature/domain/usecase/delete_city_usecase.dart';
import 'package:weather_app/features/bookmarks_feature/domain/usecase/get_all_city_usecase.dart';
import 'package:weather_app/features/bookmarks_feature/domain/usecase/get_city_usecase.dart';
import 'package:weather_app/features/bookmarks_feature/domain/usecase/save_city_usecase.dart';
import 'package:weather_app/features/bookmarks_feature/presentation/bloc/bookmark_bloc.dart';
import 'package:weather_app/features/weather_feature/data/data_source/remote/api_provider.dart';
import 'package:weather_app/features/weather_feature/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather_feature/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather_feature/domain/usecase/get_current_city_weather_usecase.dart';
import 'package:weather_app/features/weather_feature/domain/usecase/get_forecastdays_weather_usecase.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  //? database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //? api provider
  locator.registerSingleton<ApiProvider>(ApiProvider());

  //? repository
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));
  locator
      .registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));

  //? use cases
  //* current city weather use case
  locator.registerSingleton<GetCurrentCityWeatherUsecase>(
      GetCurrentCityWeatherUsecase(locator()));

  //* forecastdays weather use case
  locator.registerSingleton<GetForecastdaysWeatherUsecase>(
      GetForecastdaysWeatherUsecase(locator()));

  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));

  //? bloc
  locator.registerSingleton<WeatherBloc>(WeatherBloc(locator(), locator()));
  locator.registerSingleton<BookmarkBloc>(
      BookmarkBloc(locator(), locator(), locator(), locator()));
}
