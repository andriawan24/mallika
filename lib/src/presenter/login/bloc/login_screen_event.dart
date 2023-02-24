part of 'login_screen_bloc.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

class LoginScreenInitialEvent extends LoginScreenEvent {}

class LoginScreenSendOTPEvent extends LoginScreenEvent {
  final String phoneNumber;
  final String countryCode;

  const LoginScreenSendOTPEvent({
    required this.countryCode,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber, countryCode];
}

class LoginScreenSignInGoogleEvent extends LoginScreenEvent {}
