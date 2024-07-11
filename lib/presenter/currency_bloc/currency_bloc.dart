import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_valuta_app_dio/data/repository/currency_repository_impl.dart';
import 'package:flutter_valuta_app_dio/util/Language.dart';
import 'package:flutter_valuta_app_dio/util/status.dart';

import '../../data/sourse/remote/response/currency_response.dart';
import '../../domain/currency_repository.dart';

part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyState(language: Language.Uz)) {
    List<CurrencyModel>? listCurrency;

    on<GetCurrencyEvent>((event, emit) async {
      final CurrencyRepository repository = CurrencyRepositoryImpl();
      if (event.date == null) {
        try {
          emit(state.copyWith(status: Status.loading));
          final result = await repository.getCurrency();
          listCurrency = result;
          emit(state.copyWith(status: Status.success, data: result));
        } on DioException catch (e) {
          emit(state.copyWith(status: Status.fail, errorMessage: e.message));
        }
      } else {
        try {
          print("date bloc ${event.date}");
          emit(state.copyWith(status: Status.loading));
          final result = await repository.getCurrencyByDate(event.date!);
          listCurrency = result;
          emit(state.copyWith(status: Status.success, data: result));
        } on DioException catch (e) {
          emit(state.copyWith(status: Status.fail, errorMessage: e.message));
        }
      }
    });
    on<CurrencyLanguageEvent>((event, emit) {
      if (listCurrency != null) {
        emit(state.copyWith(language: event.language, data: listCurrency));
      }
    });
  }
}
