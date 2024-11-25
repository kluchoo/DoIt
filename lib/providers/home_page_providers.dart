import 'package:do_it/models/app_user.dart';
import 'package:do_it/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appUserProvider = ChangeNotifierProvider((ref) {
  return AppUser(
      email: "tester@gmail.com",
      uid: "BuAn4rNn57gOkLu0MqgrImjgAMk1",
      name: "Tester");
});

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

class CurrentQuoteNotifier extends ChangeNotifier {
  int skipped = 0;
  int displayed = 2;

  void increment() {
    displayed += 2;
  }
}

final currentQuoteProvider = ChangeNotifierProvider((ref) {
  return CurrentQuoteNotifier();
});
