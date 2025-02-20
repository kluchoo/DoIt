import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class Progress extends ChangeNotifier {
  final String title;
  Category category;
  final String description;
  final Uint8List? image;
  DateTime? date;

  Progress({
    required this.title,
    required this.category,
    required this.description,
    this.image,
    this.date,
  });
}

enum Category {
  trening_silowy(
    title: 'Trening siłowy',
    description:
        'Trening siłowy to rodzaj treningu, który ma na celu zwiększenie siły mięśniowej. Trening siłowy może być wykonywany z użyciem ciężarów, maszyn, lub własnej masy ciała. Trening siłowy może pomóc w zwiększeniu siły, wytrzymałości, i masy mięśniowej.',
    icon: Icons.fitness_center,
  ),

  trening_kardio(
    title: 'Trening kardio',
    description:
        'Trening kardio to rodzaj treningu, który ma na celu zwiększenie wydolności organizmu. Trening kardio może być wykonywany na przykład na bieżni, rowerze, lub poprzez bieganie. Trening kardio może pomóc w zwiększeniu wydolności, spalaniu kalorii, i poprawie kondycji fizycznej.',
    icon: Icons.directions_run,
  ),

  rozwoj_osobisty(
    title: 'Rozwój osobisty',
    description:
        'Rozwój osobisty to proces, w którym dążymy do poprawy swoich umiejętności, wiedzy, i kompetencji. Rozwój osobisty może obejmować takie obszary jak rozwój umiejętności miękkich, rozwój umiejętności zawodowych, i rozwój osobisty. Rozwój osobisty może pomóc w osiągnięciu sukcesu w życiu osobistym i zawodowym.',
    icon: Icons.person,
  ),

  postanowienie(
    title: 'Postanowienie',
    description:
        'Postanowienie to zobowiązanie, które podejmujemy wobec siebie samego. Postanowienie może dotyczyć takich obszarów jak zdrowie, kariera, czy życie osobiste. Postanowienie może pomóc w osiągnięciu celów i poprawie jakości życia.',
    icon: Icons.assignment,
  ),

  detoks(
    title: 'Detoks',
    description:
        'Postanowienie to zobowiązanie, które podejmujemy wobec siebie samego. Postanowienie może dotyczyć takich obszarów jak zdrowie, kariera, czy życie osobiste. Postanowienie może pomóc w osiągnięciu celów i poprawie jakości życia.',
    icon: Icons.assignment,
  );

  const Category({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData? icon;

  static Category fromString(String value) {
    switch (value) {
      case 'postanowienie':
        return Category.postanowienie;
      case 'trening_silowy':
        return Category.trening_silowy;
      case 'trening_kardio':
        return Category.trening_kardio;
      case 'rozwoj_osobisty':
        return Category.rozwoj_osobisty;
      case 'detoks':
        return Category.detoks;
      default:
        throw ArgumentError('Nieprawidłowa kategoria: $value');
    }
  }
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

  List<Map> serializeProgress() {
    List<Map<String, dynamic>> serializedData = progressData.map((progress) {
      return {
        'title': progress.title,
        'description': progress.description,
        'Category': progress.category.toString().split('.').last,
        'image': progress.image != null ? base64Encode(progress.image!) : null,
        'date': progress.date?.toIso8601String(),
      };
    }).toList();
    return serializedData;
  }

  Future<void> fetchProgress(WidgetRef ref) async {
    final uid = ref.read(appUserProvider).uid;
    debugPrint('UID: $uid'); // Dodaj debugowanie UID
    if (uid == null) {
      debugPrint('Użytkownik nie jest zalogowany');
      return;
    }

    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = docSnapshot.data()?['progress'];
      if (data != null) {
        deserializeProgress(List<Map>.from(data));
      }
    } catch (e) {
      debugPrint('Błąd podczas pobierania postępów: $e');
    }
  }

  Future<void> saveProgress(WidgetRef ref) async {
    final uid = ref.read(appUserProvider).uid;
    debugPrint('UID: $uid'); // Dodaj debugowanie UID
    if (uid == null) {
      debugPrint('Użytkownik nie jest zalogowany');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'progress': serializeProgress(),
        },
      );
    } catch (e) {
      debugPrint('Błąd podczas zapisywania postępów: $e');
    }
  }

  void deserializeProgress(List<Map> data) {
    List<Progress> deserializedData = data.map((progress) {
      return Progress(
        title: progress['title'],
        description: progress['description'],
        category: Category.fromString(progress['Category'] as String),
        image:
            progress['image'] != null ? base64Decode(progress['image']) : null,
        date:
            progress['date'] != null ? DateTime.parse(progress['date']) : null,
      );
    }).toList();
    progressData = deserializedData;
    notifyListeners();
  }

  void removeProgress(int index, WidgetRef ref) {
    progressData.removeAt(index);

    saveProgress(ref);
    notifyListeners();
  }
}

// final List<Progress> progressData = [];
