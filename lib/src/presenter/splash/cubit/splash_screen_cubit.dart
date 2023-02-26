import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallika/src/data/repository/auth_repository.dart';
import 'package:mallika/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final AuthRepository _authRepository;

  SplashScreenCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SplashScreenInitial());

  void checkIsLogin() async {
    bool result = _authRepository.getIsLogin();
    final sharedPreferences = await SharedPreferences.getInstance();
    bool firstTime = sharedPreferences.getBool(prefFirstLaunch) ?? true;
    if (firstTime) {
      emit(SplashScreenLoaded('onboarding'));
    } else {
      if (result) {
        emit(SplashScreenLoaded('main'));
      } else {
        emit(SplashScreenLoaded('login'));
      }
    }
  }
}
