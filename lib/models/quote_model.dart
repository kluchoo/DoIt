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
      "ownerId": "",
      "quote": quote.quote,
    });
  }

  Future<void> fetchQuotes(WidgetRef ref) async {
    // Number of documents to skip
    int skipCount = ref.watch(currentQuoteProvider).skipped;
    int displayCount = ref.watch(currentQuoteProvider).displayed;

    // Fetch all documents ordered by date descending
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('quotes')
        .orderBy('date', descending: true)
        .get();

    // Skip the desired number of documents and take the next two
    final documents = snapshot.docs.skip(0).take(displayCount);
    _quotesData.clear();
    for (var doc in documents) {
      _quotesData.add(Quote(
        ownerId: doc.id,
        date: doc['date'].toDate(),
        quote: doc['quote'],
        author: doc['author'],
        likes: doc['likes'],
      ));
    }
    notifyListeners();
  }

  Future<void> fetchAndAddQuote(Quote quote, WidgetRef ref) async {
    toFirestore(quote);
    fetchQuotes(ref);
  }
}
