import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/core/constants/controllers.dart';
import 'package:weather_app/core/utils/responsive.dart';
import 'package:weather_app/core/widgets/blur_container.dart';
import 'package:weather_app/core/widgets/loading_widget.dart';
import 'package:weather_app/features/weather_feature/data/models/city_name_suggection_model.dart';
import 'package:weather_app/features/weather_feature/domain/usecase/get_city_name_suggection_usecase.dart';
import 'package:weather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather_feature/presentation/pages/home_page.dart';
import 'package:weather_app/locator.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //* usecase
    GetCityNameSuggectionUsecase getCityNameSuggectionUsecase =
        GetCityNameSuggectionUsecase(locator());

    //* variables
    final width = ScreenUtils(context).width;
    final height = ScreenUtils(context).height;

    // widget
    return ContainerWidget(
        height: height * 0.062,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10, bottom: 0),
          child: TypeAheadField(
              controller: Controllers.textEditingController,
              loadingBuilder: (context) => const Center(child: LoadingWidget()),
              suggestionsCallback: (String prefix) {
                return getCityNameSuggectionUsecase(prefix);
              },
              builder: (context, controller, focusNode) {
                return TextField(
                  focusNode: focusNode,
                  controller: controller,
                  onSubmitted: (value) {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(LoadCurrentCityWeatherEvent(value));

                    //* save city name
                    HomePage.box.write("city", value);
                  },
                  style: TextStyle(fontSize: width * 0.057),
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Search city or location",
                      hintStyle: TextStyle(fontSize: width * 0.047)),
                );
              },
              itemBuilder: (context, Data model) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(model.name!),
                  subtitle: Text("${model.region!}, ${model.country!}"),
                );
              },
              onSelected: (Data model) {
                Controllers.textEditingController.text = model.name!;
                BlocProvider.of<WeatherBloc>(context)
                    .add(LoadCurrentCityWeatherEvent(model.name!));

                //* save city name
                HomePage.box
                    .write("city", Controllers.textEditingController.text);
              }),
        ));
  }
}

// TextField(
//             style: TextStyle(fontSize: 22),
//             decoration: InputDecoration(
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 hintText: "Search city or location",
//                 hintStyle: TextStyle(fontSize: 18)),
//           ),