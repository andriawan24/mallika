import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_screen_event.dart';
part 'otp_screen_state.dart';

class OtpScreenBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
  OtpScreenBloc() : super(OtpScreenInitial()) {
    on<OtpScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
