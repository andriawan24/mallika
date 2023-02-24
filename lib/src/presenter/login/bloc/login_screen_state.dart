part of 'login_screen_bloc.dart';

abstract class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginScreenInitial extends LoginScreenState {}

class LoginScreenLoading extends LoginScreenState {}

class LoginScreenStandBy extends LoginScreenState {
  final List<CountryCodeModel> countryCodes;
  
  const LoginScreenStandBy(this.countryCodes);

  @override
  List<Object> get props => [countryCodes];
}

class LoginScreenSuccessSocialSignIn extends LoginScreenState {}
class LoginScreenSuccessSendOTP extends LoginScreenState {}

class LoginScreenFailed extends LoginScreenState {
  final String message;

  const LoginScreenFailed(this.message);

  @override
  List<Object> get props => [message];
}
