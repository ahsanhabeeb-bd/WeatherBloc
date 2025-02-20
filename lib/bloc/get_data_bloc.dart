import 'dart:convert';
import 'package:bloc12/bloc/get_data_event.dart';
import 'package:bloc12/bloc/get_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show rootBundle;

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  GetDataBloc() : super(GetDataInitial()) {
    //  String city = "auto:ip";

    // print(citys);
    const String apikey = '549eaacd79dd4e2a85375345242310';
    const String forecasturl = "http://api.weatherapi.com/v1/forecast.json";

    Future<Map<String, dynamic>> currentweather(String searchtext) async {
      final url =
          "$forecasturl?key=$apikey&q=$searchtext&days=7&aqi=no&alerts=no";

      final Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        return jsonDecode(response.body);
      } else {
        throw Exception();
      }
    }

    Future<List<String>> loadJsonData() async {
      List<String> stateNames = [];

      String jsonString = await rootBundle.loadString('assets/countries.json');

      List<dynamic> jsonData = json.decode(jsonString);
      for (var country in jsonData) {
        // Check if 'states' key exists and is a list
        if (country['states'] is List) {
          for (var state in country['states']) {
            // Add each state name to the list
            stateNames.add(state['name']);
          }
        }
      }
      stateNames.sort((a, b) {
        if (a[0] == b[0]) {
          return a[1].compareTo(b[1]);
        } else {
          return a[0].compareTo(b[0]);
        }
      });
      return stateNames;
    }

    on<InitEvent>((event, emit) async {
      emit(GetDataInitial());

      List<String> citys = [];

      citys = await loadJsonData();

      try {
        final data = await currentweather(event.city);

        emit(DataLoaded(data, event.city, citys: citys));
      } catch (e) {
        // emit(DataError(e.toString()));
      }
    });
  }
}
