import 'package:do_it/komponenty/cytat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  final CardSwiperController swiperController = CardSwiperController();

  // List<QuotesCard> cards = [
  //   const QuotesCard("1"),
  //   const QuotesCard('2'),
  //   const QuotesCard('3'),
  // ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img/doititransparent.png',
                width: 150,
              ),
            ),
          ]),
          Flexible(
            child: CardSwiper(
                duration: const Duration(milliseconds: 100),
                maxAngle: 15,
                numberOfCardsDisplayed: 1,
                allowedSwipeDirection: const AllowedSwipeDirection.only(
                    up: false, down: false, left: true, right: true),
                isLoop: false,
                controller: swiperController,
                onSwipe: (previousIndex, currentIndex, direction) {
                  if (direction == CardSwiperDirection.right) {
                    swiperController.undo();

                    return false;
                  }
                  return true;
                },
                cardsCount: QuotesData.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  final quote = QuotesData[index];
                  return QuotesCard(quote
                      // date: quote.data,
                      );
                }),
          ),
        ],
      ),
    );
  }
}
