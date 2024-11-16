import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  final CardSwiperController swiperController = CardSwiperController();

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text('1'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text('2'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.purple,
      child: const Text('3'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Flexible(
        child: CardSwiper(
          duration: const Duration(milliseconds: 100),
          maxAngle: 15,
          numberOfCardsDisplayed: 1,
          allowedSwipeDirection: const AllowedSwipeDirection.only(
              up: false, down: false, left: true, right: true),
          isLoop: false,
          controller: swiperController,
          onSwipe: (previousIndex, currentIndex, direction) {
            if (direction == CardSwiperDirection.left) {
              swiperController.undo();
              return false;
            }

            return true;
          },
          cardsCount: cards.length,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
              cards[index],
        ),
      ),
    );
  }
}
