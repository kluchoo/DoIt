import 'dart:typed_data';

import 'package:flutter/material.dart';

class Progress extends ChangeNotifier {
  final String title;
  final String description;
  final Uint8List? image;
  final IconData? icon;

  Progress(
      {required this.title, required this.description, this.image, this.icon});
}

class ProgressNotifier extends ChangeNotifier {
  List<Progress> progressData = [];

  void updateProgress(List<Progress> newProgress) {
    progressData = newProgress;
    notifyListeners();
  }

  void addProgress(Progress newProgress) {
    progressData.add(newProgress);
    notifyListeners();
  }
}

final List<Progress> progressData = [
  Progress(
    title: 'title',
    description: 'description',
    image: null,
    icon: null,
  ),
  Progress(
    title: 'title',
    description: 'description',
    image: null,
    icon: null,
  ),
];
