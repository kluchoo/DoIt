import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/komponenty/cytat.dart';
import 'package:flutter/material.dart';

class QuotesModel extends ChangeNotifier {
  final List<Quote> _quotesData = [
    Quote(
      ownerId: '0',
      date: '',
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

  Future<void> fetchQuotes() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('quotes').get();
    _quotesData.clear();
    for (var doc in snapshot.docs) {
      _quotesData.add(Quote(
        ownerId: doc.id,
        date: doc['date'],
        quote: doc['quote'],
        author: doc['author'],
        likes: doc['likes'],
      ));
    }
    notifyListeners();
  }

  Future<void> fetchAndAddQuote(Quote quote) async {
    toFirestore(quote);
    fetchQuotes();
  }
}
