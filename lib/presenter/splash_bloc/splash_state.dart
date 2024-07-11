part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {
  bool IsOpenCurrencyScreen ;

  SplashInitial({required this.IsOpenCurrencyScreen});
}
