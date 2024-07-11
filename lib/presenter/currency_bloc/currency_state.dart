part of 'currency_bloc.dart';

class CurrencyState {
  final Language? language;
  final Status? status;
  final String? errorMessage;
  final List<CurrencyModel>? data;

  CurrencyState({this.language, this.status, this.errorMessage, this.data});

  CurrencyState copyWith(
          {Language? language,
          Status? status,
          String? errorMessage,
          List<CurrencyModel>? data}) =>
      CurrencyState(
          language: language ?? this.language,
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          data: data ?? this.data);
}
