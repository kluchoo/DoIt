import 'package:do_it/komponenty/cytat.dart';
import 'package:do_it/strony/aplikacja/zakladki/tworzenie_cytatu.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:do_it/providers/home_page_providers.dart';

class Quotes extends ConsumerStatefulWidget {
  const Quotes({
    super.key,
  });

  @override
  ConsumerState<Quotes> createState() => _QuotesState();
}

class _QuotesState extends ConsumerState<Quotes> {
  final CardSwiperController swiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    final quotesModel = ref.watch(quotesProvider);
    if (quotesModel.quotesData.length == 1) {
      ref.read(quotesProvider).fetchQuotes(ref, context);
    }

    return FractionallySizedBox(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img/doititransparent.png',
                width: 150,
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 120, 40, 0),
                child: IconButton.filled(
                    style: ButtonStyle(
                        iconSize: const WidgetStatePropertyAll(40),
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.primaryColor),
                        iconColor: const WidgetStatePropertyAll(Colors.black),
                        elevation: const WidgetStatePropertyAll(0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => TworzenieCytatu()));
                    },
                    icon: const Icon(Icons.add)))
          ]),
          Flexible(
            child: CardSwiper(
                duration: const Duration(milliseconds: 150),
                numberOfCardsDisplayed: 1,
                allowedSwipeDirection: const AllowedSwipeDirection.only(
                    up: false, down: false, left: true, right: true),
                isLoop: false,
                controller: swiperController,
                onEnd: () async {
                  bool status = await ref
                      .refresh(quotesProvider)
                      .fetchQuotes(ref, context);

                  if (status == true) {
                    swiperController.undo();
                  } else {
                    swiperController.undo();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'ładowanie cytatów',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              8.0, // Inner padding for SnackBar content.
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
                onSwipe: (previousIndex, currentIndex, direction) {
                  if (direction == CardSwiperDirection.right) {
                    swiperController.undo();
                    return false;
                  }
                  return true;
                },
                cardsCount: quotesModel.quotesData.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  final quote = quotesModel.quotesData[index];
                  return QuotesCard(quote);
                }),
          ),
        ],
      ),
    );
  }
}
