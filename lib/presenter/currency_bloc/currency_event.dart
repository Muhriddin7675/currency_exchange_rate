part of 'currency_bloc.dart';

abstract class CurrencyEvent {}

class GetCurrencyEvent extends CurrencyEvent {
  final String? date;

  GetCurrencyEvent({this.date});
}

class CurrencyLanguageEvent extends CurrencyEvent {
   Language language;

  CurrencyLanguageEvent(this.language);
}
