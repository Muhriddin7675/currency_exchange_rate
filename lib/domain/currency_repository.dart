import '../data/sourse/remote/response/currency_response.dart';

abstract class CurrencyRepository {
  Future<List<CurrencyModel>> getCurrency();
  Future<List<CurrencyModel>> getCurrencyByDate(String date);
}
