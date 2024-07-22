import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_valuta_app_dio/data/sourse/remote/response/currency_response.dart';
import 'package:flutter_valuta_app_dio/presenter/currency_bloc/currency_bloc.dart';
import 'package:flutter_valuta_app_dio/util/formater/currency_input_formater.dart';
import 'package:intl/intl.dart';

import '../../util/Language.dart';

class Itemcurrency extends StatefulWidget {
  final BuildContext buildContext;
  final CurrencyModel data;

  Itemcurrency({super.key, required this.data, required this.buildContext});

  @override
  State<Itemcurrency> createState() => _ItemcurrencyState();
}

class _ItemcurrencyState extends State<Itemcurrency> {
  void bottomSheetDialog({required BuildContext context, required String code, required String ccyName, required String from, required double rate}) {
    var isUzsToCcy = false;

    var uzsController = TextEditingController();
    var ccyController = TextEditingController();

    String formatNumber(double number) {
      final NumberFormat numberFormat = NumberFormat('#,###,###', 'en_US');
      return numberFormat.format(number);
    }
    void _convertListener() {
      if (isUzsToCcy) {
        if (uzsController.text.isNotEmpty) {
          double uzs = double.tryParse(uzsController.text.replaceAll(",", "")) ?? 1;
          double ccy = uzs / rate;
          ccyController.text = formatNumber(ccy);
        } else {
          ccyController.clear();
        }
      } else {
        if (uzsController.text.isNotEmpty) {
          double ccy = double.tryParse(uzsController.text.replaceAll(",", "")) ?? 1;
          double uzs = ccy * rate;
          ccyController.text = formatNumber(uzs);
        } else {
          ccyController.clear();
        }
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 286.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Container(
                      width: 50,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.black12,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Center(
                      child: Text(
                        from,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Column(
                      children: [
                        const SizedBox(height: 4),
                        TextField(
                          onChanged: (text) {
                            _convertListener();
                          },
                          maxLength: 21,
                          inputFormatters: [
                            CurrencyInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          controller: uzsController,
                          decoration: InputDecoration(
                            labelText: isUzsToCcy ? 'UZS' : ccyName,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          readOnly: true,
                          controller: ccyController,
                          decoration: InputDecoration(
                            labelText: isUzsToCcy ? ccyName : 'UZS',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isUzsToCcy = !isUzsToCcy;
                          var text = uzsController.text;
                          uzsController.text = ccyController.text;
                          ccyController.text = text;
                          setState(() {});
                        });
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.lightBlue,
                          ),
                          child: const Icon(
                            Icons.swap_vert,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getLanguage() {
    Language language = widget.buildContext.read<CurrencyBloc>().state.language!;
    switch (language) {
      case Language.En:
        return widget.data.ccyNmEn ?? '';
      case Language.Ru:
        return widget.data.ccyNmRu ?? '';
      case Language.Uz:
        return widget.data.ccyNmUz ?? '';
      case Language.UzC:
        return widget.data.ccyNmUzc ?? '';
    }
  }

  String _getCalculateLanguage() {
    Language language = widget.buildContext.read<CurrencyBloc>().state.language!;

    switch (language) {
      case Language.En:
        return "Calculate";
      case Language.Ru:
        return "Рассчитать";
      case Language.Uz:
        return "Hisoblash";
      case Language.UzC:
        return "Х,исоблаш";
    }
  }

  var isItemOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.white,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _getLanguage(),
                              style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.data.diff ?? '',
                              style: TextStyle(fontSize: 14, color: (widget.data.diff ?? "").startsWith('-') ? Colors.red : Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '1 ${widget.data.ccy} => ${widget.data.rate} UZS\t|\t',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Image.asset(
                              "assets/calendar.png",
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              "\t ${widget.data.date}",
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isItemOpen = !isItemOpen;
                        });
                      },
                      icon: Icon((isItemOpen) ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: isItemOpen,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 12, top: 2),
                    child: GestureDetector(
                      onTap: () {
                        bottomSheetDialog(
                            context: widget.buildContext,
                            code: widget.data.code ?? "0",
                            ccyName: widget.data.ccy ?? "0",
                            from: _getLanguage(),
                            rate: double.tryParse(widget.data.rate ?? "1") ?? 1);
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.lightBlue),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calculate,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _getCalculateLanguage(),
                                style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
