import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallika/router/app_router.dart';
import 'package:mallika/src/presenter/splash/cubit/splash_screen_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      context.read<SplashScreenCubit>().checkIsLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenLoaded) {
            router.go('/${state.nextRoute}');
          }
        },
        builder: (context, state) {
          return const Center(
            child: Text(
              'mallika',
            ),
          );
        },
      ),
    );
  }
}
