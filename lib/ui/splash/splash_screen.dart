import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_valuta_app_dio/ui/currency/currency_screen.dart';

import '../../presenter/currency_bloc/currency_bloc.dart';
import '../../presenter/splash_bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
        SplashBloc()
          ..add(OpenCurrencyScreenEvent()),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashInitial) {
              if (state.IsOpenCurrencyScreen) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        BlocProvider(
                          create: (context) => CurrencyBloc(),
                          child: const CurrencyScreen(),
                        )));
              }
            }
          },
          child: Center(
            child: Image.asset(
              "assets/app_icon.png",
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
