import 'package:do_it/komponenty/app_background_colors.dart';
import 'package:do_it/komponenty/botom_navigation_bar.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  void updateIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFFF914d),
              Color(0xFFFFde59),
              Color(0xFFFFde59),
              Color(0xFFFF914d)
            ], stops: [
              0,
              0.4,
              0.6,
              1
            ])),
            child: Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: StylizowanyTytul(context.watch<TitleProvider>().title),
            )),
          ),
        ),
        body: MainAppBackground(Stack(
          children: [
            IndexedStack(
              index: index,
              children: const [
                Center(
                  child: StylizowanyTytul('Cytaty'),
                ), // Widok dla index == 0
                Center(
                  child: StylizowanyTytul('Postępy'),
                ), // Widok dla index == 1
                Center(
                  child: StylizowanyTytul('Plan Treningowy'),
                ), // Widok dla index == 2
              ],
            ),
            Column(
              children: [
                const Expanded(child: SizedBox()),
                CustomBottomNavigationBar(
                  chosenIndex: index,
                  onItemSelected: updateIndex, // Przekazywanie funkcji
                )
              ],
            )
          ],
        )));
  }
}
