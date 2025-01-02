import 'package:do_it/models/progress_model.dart';
import 'package:flutter/material.dart';

class ProgressFormState extends ChangeNotifier {
  String title = '';
  String description = '';
  Category? selectedCategory;
  String chosenCategory = 'Wybierz kategorię';

  void updateTitle(String value) {
    title = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    description = value;
    notifyListeners();
  }

  void updateCategory(Category category) {
    selectedCategory = category;
    chosenCategory = category.name;
    notifyListeners();
  }
}
