import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Yangi matnni olish
    final newText = newValue.text;

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Faqat raqamlarni qoldirish
    final digitsOnly = newText.replaceAll(RegExp(r'[^\d]'), '');

    // Raqamlarni `int` ga o'zgartirish
    final number = int.tryParse(digitsOnly) ?? 0;

    // Raqamlarni formatlash
    final formattedNumber = _currencyFormat.format(number);

    return newValue.copyWith(
      text: formattedNumber,
      selection: TextSelection.collapsed(offset: formattedNumber.length),
    );
  }
}
