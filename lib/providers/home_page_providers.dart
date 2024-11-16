import 'package:flutter/material.dart';

class TitleProvider extends ChangeNotifier {
  String title;
  TitleProvider({
    this.title = "Cytaty",
  });
  void changeTitle(String title) {
    this.title = title;
    notifyListeners();
  }
}
