import 'package:do_it/models/app_user.dart';
import 'package:do_it/models/progress_model.dart';
import 'package:do_it/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appUserProvider = ChangeNotifierProvider((ref) {
  return AppUser(uid: "null", email: "null", name: "null");
});

final quotesProvider = ChangeNotifierProvider((ref) {
  return QuotesModel();
});

final titleProvider = ChangeNotifierProvider((ref) {
  return TitleProvider();
});

final progressProvider = ChangeNotifierProvider((ref) {
  return ProgressNotifier();
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

  void restart() {
    displayed = 2;
  }
}

final currentQuoteProvider = ChangeNotifierProvider((ref) {
  return CurrentQuoteNotifier();
});
