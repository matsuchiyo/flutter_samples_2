
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  final locales = const [
    Locale('ja', 'JP'),
    Locale('en', 'US'),
    Locale('fr', 'FR'),
  ];

  final currencies = const [
    'JPY',
    'USD',
    'EUR',
  ];

  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: locales.expand((locale) {
          return currencies.map((currency) {
            final item = _ItemModel(locale, currency, 12345.67);
            return Localizations.override(
              context: context,
              locale: locale,
              child: _ItemView(item: item),
            );
          });
        }).toList(),
      ),
    );
  }
}

class _ItemModel {
  final Locale locale;
  final String currency;
  final double value;
  const _ItemModel(this.locale, this.currency, this.value);
}

class _ItemView extends StatelessWidget {
  final _ItemModel item;
  const _ItemView({ super.key, required this.item, });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Text(
        _createText(item),
      ),
    );
  }

  String _createText(_ItemModel item) {
    final numberFormat = NumberFormat.simpleCurrency(locale: item.locale.toString(), name: item.currency);
    return '${item.locale} / ${item.currency} / ${numberFormat.format(item.value)}';
  }
}