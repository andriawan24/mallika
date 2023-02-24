import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallika/src/data/repository/auth_repository.dart';
part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final AuthRepository _authRepository;

  SplashScreenCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SplashScreenInitial());

  void checkIsLogin() {
    bool result = _authRepository.getIsLogin();
    if (result) {
      emit(SplashScreenLoaded('home'));
    } else {
      emit(SplashScreenLoaded('login'));
    }
  }
}
