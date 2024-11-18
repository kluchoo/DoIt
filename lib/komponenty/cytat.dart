import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuotesCard extends StatefulWidget {
  const QuotesCard(this.quote, {super.key});

  final Quote quote;

  @override
  State<QuotesCard> createState() => _QuotesCardState();
}

class _QuotesCardState extends State<QuotesCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
              color: Color(0xfffff9f5),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    blurRadius: 10,
                    spreadRadius: 5)
              ]),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 28),
              child: Center(
                  child: GestureDetector(
                onDoubleTap: () {},
                child: SingleChildScrollView(
                  child: RichText(
                      softWrap: true,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\"',
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: const Color(0xff5ce1e6),
                              fontWeight: FontWeight.w800,
                            ), // Kolor cudzysłowów
                          ),
                          TextSpan(
                            text: widget.quote.quote,
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              letterSpacing: 1,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w800,
                            ), // Kolor cudzysłowów
                          ),
                          TextSpan(
                            text: '\"',
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: const Color(0xff5ce1e6),
                              fontWeight: FontWeight.w800,
                            ), // Kolor cudzysłowów
                          ),
                        ],
                      )),
                ),
              )),
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 214, 28, 28),
                      ),
                      Text(
                        widget.quote.likes.toString(),
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          letterSpacing: 1,
                          color: const Color.fromARGB(255, 214, 28, 28),
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ],
                  ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                  child: Row(
                    children: [
                      Text(
                        widget.quote.date.toString(),
                        style: GoogleFonts.openSans(
                            fontSize: 12,
                            letterSpacing: 1,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ))
          ]),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
          child: Row(
            children: [
              Text(
                'Autor: ',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  letterSpacing: 1,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                widget.quote.author,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  letterSpacing: 1,
                  color: const Color(0xff5ce1e6),
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

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
  final String date;
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
  final String date;
  final String quote;
  final String author;
  int likes;
}

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
