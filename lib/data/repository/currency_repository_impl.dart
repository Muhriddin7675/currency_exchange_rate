import 'package:dio/dio.dart';
import 'package:flutter_valuta_app_dio/data/sourse/remote/response/currency_response.dart';
import 'package:flutter_valuta_app_dio/data/sourse/remote/service/api_service.dart';
import 'package:flutter_valuta_app_dio/data/sourse/remote/service/api_service_impl.dart';
import 'package:flutter_valuta_app_dio/domain/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final ApiService apiService = ApiServiceImpl();

  @override
  Future<List<CurrencyModel>> getCurrency() {
    try {
      final result = apiService.getCurrency();
      return result;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<CurrencyModel>> getCurrencyByDate(String date) {
    try {
      final result = apiService.getCurrencyByDate(date);
      return result;
    } on DioException {
      rethrow;
    }
  }
}
