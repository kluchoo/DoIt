import 'package:do_it/komponenty/app_background_colors.dart';
import 'package:do_it/komponenty/botom_navigation_bar.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

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
        body: MainAppBackground(Stack(
          children: [
            Column(
              children: [
                IndexedStack(
                  index: index,
                  children: [
                    Column(
                      children: [Text('data')],
                    ), // Widok dla index == 0
                    Column(
                      children: [Text('lol')],
                    ), // Widok dla index == 1
                    Column(), // Widok dla index == 2
                  ],
                ),
                const Expanded(child: SizedBox()),
                CustomBottomNavigationBar(
                  chosenIndex: index,
                  onItemSelected: updateIndex, // Przekazywanie funkcji
                ),
              ],
            )
          ],
        )));
  }
}
