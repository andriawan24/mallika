import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mallika/src/data/repository/auth_repository_impl.dart';
import 'package:mallika/src/presenter/login/login_page.dart';
import 'package:mallika/src/presenter/main/main_page.dart';
import 'package:mallika/src/presenter/splash/splash_screen.dart';
import 'package:mallika/src/presenter/splash/splash_screen_cubit.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => SplashScreenCubit(
            authRepository: AuthRepositoryImpl(),
          ),
          child: const SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return const MainPage();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    )
  ],
);
