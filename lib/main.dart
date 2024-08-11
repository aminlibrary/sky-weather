import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/bottom_nav_provider.dart';
import 'package:weather_app/core/widgets/main_wrapper.dart';
import 'package:weather_app/features/bookmarks_feature/presentation/bloc/bookmark_bloc.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //? init get storage
  await GetStorage.init();

  //? init locator
  await setup();

  //? run app
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Sky Weather",
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => locator<WeatherBloc>(),
            ),
            BlocProvider(
              create: (_) => locator<BookmarkBloc>(),
            )
          ],
          child: const MainWrapper(),
        ));
  }
}
