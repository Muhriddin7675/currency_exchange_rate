import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_valuta_app_dio/data/sourse/remote/response/currency_response.dart';
import 'package:flutter_valuta_app_dio/presenter/currency_bloc/currency_bloc.dart';
import 'package:flutter_valuta_app_dio/ui/currency/ItemCurrency.dart';
import 'package:intl/intl.dart';

import '../../util/Language.dart';
import '../../util/status.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final bloc = CurrencyBloc();
  DateTime selectedDate = DateTime.now();
  var language = Language.Uz;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime.now(),
      selectableDayPredicate: (DateTime date) {
        return date.isBefore(DateTime.now().add(const Duration(days: 1)));
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      var selectDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      bloc.add(GetCurrencyEvent(date: selectDate));
    }
  }


  String _getTitleLanguage(Language language) {
    switch (language) {
      case Language.En:
        return "Currency";
      case Language.Ru:
        return "Валюта";
      case Language.Uz:
        return "Valyuta";
      case Language.UzC:
        return "Валюта";
      default:
        return "Currency";
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    bloc.add(GetCurrencyEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
        backgroundColor: Colors.lightBlue,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: BlocBuilder<CurrencyBloc, CurrencyState>(
            bloc: bloc,
            builder: (context, state) {
              return Text(
                _getTitleLanguage(state.language ?? Language.Uz),
                style: const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _selectDate(context);
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      return SizedBox(
                        height: 220,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                                width: 56,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.black12),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      language = Language.Uz;
                                      bloc.add(CurrencyLanguageEvent(Language.Uz));
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      (language == Language.Uz)
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.lightBlue,
                                            )
                                          : const Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.black,
                                            ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text("O'zbekcha",
                                            style: TextStyle(fontSize: 16, color: (language == Language.Uz) ? Colors.lightBlue : Colors.black)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: double.infinity, height: 0.6, color: Colors.black26),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      language = Language.UzC;
                                      bloc.add(CurrencyLanguageEvent(Language.UzC));
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      (language == Language.UzC)
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.lightBlue,
                                            )
                                          : const Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.black,
                                            ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text("Узбекча",
                                            style: TextStyle(fontSize: 16, color: (language == Language.UzC) ? Colors.lightBlue : Colors.black)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: double.infinity, height: 0.6, color: Colors.black26),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      language = Language.Ru;
                                      bloc.add(CurrencyLanguageEvent(Language.Ru));
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      (language == Language.Ru)
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.lightBlue,
                                            )
                                          : const Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.black,
                                            ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text("Русский",
                                            style: TextStyle(fontSize: 16, color: (language == Language.Ru) ? Colors.lightBlue : Colors.black)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: double.infinity, height: 0.6, color: Colors.black26),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      language = Language.En;
                                      bloc.add(CurrencyLanguageEvent(Language.En));
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      (language == Language.En)
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.lightBlue,
                                            )
                                          : const Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.black,
                                            ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text("English",
                                            style: TextStyle(fontSize: 16, color: (language == Language.En) ? Colors.lightBlue : Colors.black)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: double.infinity, height: 0.6, color: Colors.black26),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<CurrencyBloc, CurrencyState>(
          listener: (context, state) {
            if (state.status == Status.fail) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state.status == Status.fail) {
                return const Placeholder();
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    bloc.add(GetCurrencyEvent());
                    await Future.delayed(const Duration(milliseconds: 200));
                  },
                  child: ListView.builder(
                    itemCount: state.data?.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Itemcurrency(
                        buildContext: context,
                        data: state.data?[index] ??
                            CurrencyModel(
                                id: -1,
                                code: "",
                                ccy: "",
                                ccyNmRu: "",
                                ccyNmUz: "",
                                ccyNmUzc: "",
                                ccyNmEn: "",
                                nominal: "nominal",
                                rate: "rate",
                                diff: "diff",
                                date: "date"),
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
