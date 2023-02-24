import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mallika/src/data/models/country_code_model.dart';
import 'package:mallika/src/domain/repository/auth_repository.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final AuthRepository _repository;

  LoginScreenBloc(AuthRepository repository)
      : _repository = repository,
        super(LoginScreenInitial()) {
    on<LoginScreenInitialEvent>((event, emit) async {
      emit(LoginScreenLoading());
      var results = await _repository.getCountryCodes();
      emit(LoginScreenStandBy(results));
    });

    on<LoginScreenSendOTPEvent>((event, emit) async {
      try {
        emit(LoginScreenLoading());
        var result = await _repository.signInWithOtp(
          event.countryCode,
          event.phoneNumber,
        );
        if (result) emit(LoginScreenSuccessSendOTP());
      } catch (e) {
        emit(LoginScreenFailed(e.toString()));
      }
    });

    on<LoginScreenSignInGoogleEvent>((event, emit) async {
      try {
        emit(LoginScreenLoading());
        var result = await _repository.signInWithGoogle();
        if (result) emit(LoginScreenSuccessSocialSignIn());
      } catch (e) {
        emit(LoginScreenFailed(e.toString()));
      }
    });
  }
}
