import 'package:do_it/models/quote_model.dart';
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
                        '${widget.quote.date.toUtc().day}.${widget.quote.date.toUtc().month}.${widget.quote.date.toUtc().year}',
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
