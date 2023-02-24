part of 'splash_screen_cubit.dart';

@immutable
abstract class SplashScreenState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenLoaded extends SplashScreenState {
  final String nextRoute;
  SplashScreenLoaded(this.nextRoute);

  @override
  List<Object?> get props => [nextRoute];
}
