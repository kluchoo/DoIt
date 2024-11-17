import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuotesCard extends StatefulWidget {
  QuotesCard(this.quote, {super.key});

  Quote quote;

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
                onDoubleTap: () {
                  setState(() {
                    print(
                        '${widget.quote.id} ${widget.quote.quote} ${widget.quote.likes}');
                    // widget.quote._isFav;
                  });
                },
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
      {required this.id,
      required this.date,
      required this.quote,
      required this.author,
      required this.likes});

  //gettery

  // pola
  final int id;
  bool _isFav = false;
  final String date;
  final String quote;
  final String author;
  int likes;

  void toggleIsFav() {
    _isFav = !_isFav;
    if (_isFav == true) {
      likes++;
    } else {
      likes--;
    }
  }
}

List<Quote> quotesData = [
  Quote(
    id: 0,
    date: '16.11.2024',
    quote: 'W tym właśnie punkcie język potoczny rezygnuje i wychodzi na piwo.',
    author: "Nieznany autor",
    likes: 100,
  ),
  Quote(
    id: 1,
    date: '14.11.2024',
    quote:
        'Generalnie rzecz biorąc, ja jestem w jednej dziedzinie za równouprawnieniem, a mianowicie: żeby w małżeństwie było 50% mężczyzn i 50% kobiet.',
    author: "Janusz Korwin-Mikke",
    likes: 21,
  ),
  Quote(
    id: 2,
    date: '14.11.2024',
    quote: 'Państwa nie mają przyjażni tylko interesy',
    author: "Winston Churchill",
    likes: 1981,
  ),
  Quote(
    id: 3,
    date: '01.11.2020',
    quote:
        'lLorem ipsum odor amet, consectetuer adipiscing elit. Lobortis sociosqu in interdum donec primis pellentesque vitae enim orci. Rutrum senectus vel nunc dis finibus nibh sem. Suspendisse maecenas varius maecenas bibendum ornare. Rhoncus primis fringilla primis taciti bibendum habitant inceptos a ad. Etiam porttitor eget luctus nostra in litora conubia? Ridiculus suspendisse ac duis malesuada volutpat; sed tempus venenatis. Libero diam potenti ridiculus tristique potenti amet. Habitant lectus urna duis libero conubia; porta elit. Augue posuere morbi in class purus facilisi porttitor id. Facilisi hac fermentum donec orci leo hendrerit efficitur. Magna senectus quam feugiat parturient ad at taciti. Parturient molestie sodales suspendisse mus phasellus; orci himenaeos velit mus. Finibus dis neque conubia ut hendrerit sapien nisi aenean congue. Est pellentesque venenatis odio feugiat fringilla conubia varius. Cras nostra lobortis tempor ullamcorper netus magnis potenti malesuada.',
    author: "Winston Churchill",
    likes: 21841,
  ),
];
