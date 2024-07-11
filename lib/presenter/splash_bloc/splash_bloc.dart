import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<OpenCurrencyScreenEvent, SplashState> {
  SplashBloc() : super(SplashInitial(IsOpenCurrencyScreen: false)) {
    on<OpenCurrencyScreenEvent>((event, emit) {
      Future.delayed(const Duration (seconds: 1));
      emit(SplashInitial(IsOpenCurrencyScreen: true));
    });
  }
}
