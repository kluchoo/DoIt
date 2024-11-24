import 'package:do_it/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quotesProvider = ChangeNotifierProvider((ref) {
  return QuotesModel();
});

final titleProvider = ChangeNotifierProvider((ref) {
  return TitleProvider();
});

class TitleProvider extends ChangeNotifier {
  TitleProvider({
    this.title = "Cytaty",
  });

  String title;

  void changeTitle(String title) {
    this.title = title;
    notifyListeners();
  }
}
