import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Quote {
  //konstruktor
  Quote(
      {required this.ownerId,
      required this.date,
      required this.quote,
      required this.author,
      required this.likes});

  //gettery

  // pola
  final String ownerId;
  final DateTime date;
  final String quote;
  final String author;
  int likes;
}

class QuoteToCreate {
  //konstruktor
  QuoteToCreate(
      {required this.date,
      required this.quote,
      required this.author,
      required this.likes});

  //gettery

  // pola
  final bool isFav = false;
  final DateTime date;
  final String quote;
  final String author;
  int likes;
}

class QuotesModel extends ChangeNotifier {
  final List<Quote> _quotesData = [
    Quote(
      ownerId: '0',
      date: DateTime.now(),
      quote: '',
      author: "",
      likes: 0,
    ),
  ];

  List<Quote> get quotesData => _quotesData;

  void addQuote(Quote quote) {
    toFirestore(quote);
    notifyListeners();
  }

  Future<void> toFirestore(Quote quote) async {
    await FirebaseFirestore.instance.collection('quotes').add({
      "author": quote.author,
      "date": DateTime.now(),
      "likes": 0,
      "ownerId": quote.ownerId,
      "quote": quote.quote,
    });
  }

  Future<bool> fetchQuotes(WidgetRef ref, BuildContext context) async {
    // Number of documents to skip
    int skipCount = ref.watch(currentQuoteProvider).skipped;
    int displayCount = ref.watch(currentQuoteProvider).displayed;

    // Fetch all documents ordered by date ascending
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('quotes')
        .orderBy('date', descending: false)
        .get();

    final List<DocumentSnapshot> docs = snapshot.docs.toList();

    // Logowanie wartości
    debugPrint(
        'Total docs: ${docs.length}, skipCount: $skipCount, displayCount: $displayCount');

    if (skipCount + displayCount > docs.length) {
      // Brak więcej cytatów do załadowania
      debugPrint('No more quotes to load. Restarting...');
      // ref.read(currentQuoteProvider.notifier).restart();
      // _quotesData.clear();
      notifyListeners();
      return false;
    } else {
      final String userId = ref.watch(appUserProvider).uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'watchedQuotes': FieldValue.increment(2),
      });

      final documents = docs.skip(skipCount).take(displayCount);
      _quotesData.clear();

      // Dodanie cytatów do listy
      for (var doc in documents) {
        _quotesData.add(Quote(
          ownerId: doc.id,
          date: doc['date'].toDate(),
          quote: doc['quote'],
          author: doc['author'],
          likes: doc['likes'],
        ));
      }

      // Logowanie długości listy
      debugPrint('Quotes loaded: ${_quotesData.length}');

      if (hasListeners) {
        notifyListeners();
      }

      // Zwiększenie skipCount o liczbę pobranych cytatów
      ref.read(currentQuoteProvider.notifier).increment();

      return true;
    }
  }

  Future<void> fetchAndAddQuote(Quote quote, WidgetRef ref, context) async {
    toFirestore(quote);
    fetchQuotes(ref, context);
  }
}
