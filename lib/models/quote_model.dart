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

  Future<bool> fetchQuotes(WidgetRef ref, context) async {
    // Number of documents to skip
    int skipCount = ref.watch(currentQuoteProvider).skipped;
    int displayCount = ref.watch(currentQuoteProvider).displayed;

    // Fetch all documents ordered by date descending
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('quotes')
        .orderBy('date', descending: false)
        .get();

    final List<DocumentSnapshot> docs = snapshot.docs.toList();

    if (docs.length % 2 != 0) {
      docs.removeLast();
    }

    if ((displayCount) + skipCount > docs.length) {
      ref.read(currentQuoteProvider).restart();
      return true;
    } else {
      if (docs.isEmpty) {
        return true;
      } else {
        final String userId = ref.watch(appUserProvider).uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'watchedQuotes': FieldValue.increment(2),
        });

        debugPrint((docs.length.toString()) +
            ' ' +
            (displayCount).toString() +
            " " +
            (quotesData.length).toString());

        final documents = docs.skip(skipCount).take(displayCount);
        _quotesData.clear();

        if (displayCount + 2 < docs.length) {
          ref.read(currentQuoteProvider.notifier).increment();
          for (var doc in documents) {
            _quotesData.add(Quote(
              ownerId: doc.id,
              date: doc['date'].toDate(),
              quote: doc['quote'],
              author: doc['author'],
              likes: doc['likes'],
            ));
          }
          debugPrint("1");
          notifyListeners();
          return true;
        } else if (displayCount + 2 == docs.length) {
          ref.read(currentQuoteProvider.notifier).increment();
          for (var doc in documents) {
            _quotesData.add(Quote(
              ownerId: doc.id,
              date: doc['date'].toDate(),
              quote: doc['quote'],
              author: doc['author'],
              likes: doc['likes'],
            ));
          }
          debugPrint("2");
          notifyListeners();
          return true;
        } else {
          for (var doc in documents) {
            _quotesData.add(Quote(
              ownerId: doc.id,
              date: doc['date'].toDate(),
              quote: doc['quote'],
              author: doc['author'],
              likes: doc['likes'],
            ));
          }
          debugPrint("3");
          notifyListeners();
          return false;
        }
      }
    }
  }

  Future<void> fetchAndAddQuote(Quote quote, WidgetRef ref, context) async {
    toFirestore(quote);
    fetchQuotes(ref, context);
  }
}
