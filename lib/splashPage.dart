// ignore_for_file: prefer_const_constructors

import 'package:bloc12/bloc/get_data_bloc.dart';
import 'package:bloc12/bloc/get_data_event.dart';
import 'package:bloc12/bloc/get_data_state.dart';
import 'package:bloc12/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    context.read<GetDataBloc>().add(InitEvent("auto:ip"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDataBloc, GetDataState>(
      listener: (context, state) {
        if (state is DataLoaded) {
          // print(state.weatherdata);
          // print(state.city);
          //  print(state.citys);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
