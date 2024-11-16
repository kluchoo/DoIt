import 'package:do_it/providers/home_page_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    this.chosenIndex = 0,
    required this.onItemSelected, // Funkcja do zmiany index
    super.key,
  });

  final int chosenIndex;
  final ValueChanged<int>
      onItemSelected; // Typ dla funkcji, która zmienia index

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  widget.onItemSelected(0);
                  context.read<TitleProvider>().changeTitle('Cytaty');
                },
                child: widget.chosenIndex == 0
                    ? FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Kolor cienia z przezroczystością
                                  spreadRadius: 5, // Rozprzestrzenianie cienia
                                  blurRadius: 10, // Rozmycie cienia
                                  offset: const Offset(0, 5),
                                )
                              ],
                              gradient: const SweepGradient(
                                colors: [Color(0xffffde59), Color(0xfffc466b)],
                                stops: [0.2, 0.7],
                                center: Alignment.topRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset('assets/img/quotes.png',
                                    height: 50,
                                    width: 50,
                                    color: const Color.fromARGB(224, 0, 0, 0),
                                    fit: BoxFit.scaleDown),
                              ),
                            )),
                      )
                    : FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 1,
                        child: Container(
                            decoration: const BoxDecoration(
                              gradient: SweepGradient(
                                colors: [Color(0xffc6e9ed), Color(0xffa3b2ff)],
                                stops: [0.7, 1],
                                center: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset('assets/img/quotes.png',
                                    height: 50,
                                    width: 50,
                                    color: const Color.fromARGB(101, 0, 0, 0),
                                    fit: BoxFit.scaleDown),
                              ),
                            )),
                      ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  widget.onItemSelected(1);
                  context.read<TitleProvider>().changeTitle('Postępy');
                }, // Wywołanie funkcji przy kliknięciu
                child: widget.chosenIndex == 1
                    ? FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Kolor cienia z przezroczystością
                                  spreadRadius: 5, // Rozprzestrzenianie cienia
                                  blurRadius: 10, // Rozmycie cienia
                                  offset: const Offset(0, 5),
                                )
                              ],
                              gradient: const SweepGradient(
                                colors: [Color(0xffffde59), Color(0xfffc466b)],
                                stops: [0.2, 0.7],
                                center: Alignment.topRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset('assets/img/notes.png',
                                    height: 50,
                                    width: 50,
                                    color: const Color.fromARGB(224, 0, 0, 0),
                                    fit: BoxFit.scaleDown),
                              ),
                            )),
                      )
                    : FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 1,
                        child: Container(
                            decoration: const BoxDecoration(
                              gradient: SweepGradient(
                                colors: [Color(0xffc6e9ed), Color(0xffa3b2ff)],
                                stops: [0.7, 1],
                                center: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset('assets/img/notes.png',
                                    height: 50,
                                    width: 50,
                                    color: const Color.fromARGB(101, 0, 0, 0),
                                    fit: BoxFit.scaleDown),
                              ),
                            )),
                      ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  widget.onItemSelected(2);
                  context.read<TitleProvider>().changeTitle('Plan Treningowy');
                }, // Wywołanie funkcji przy kliknięciu
                child: widget.chosenIndex == 2
                    ? FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Kolor cienia z przezroczystością
                                  spreadRadius: 5, // Rozprzestrzenianie cienia
                                  blurRadius: 10, // Rozmycie cienia
                                  offset: const Offset(0, 5),
                                )
                              ],
                              gradient: const SweepGradient(
                                colors: [Color(0xffffde59), Color(0xfffc466b)],
                                stops: [0.2, 0.7],
                                center: Alignment.topRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                    'assets/img/weight-scale.png',
                                    height: 50,
                                    width: 50,
                                    color: const Color.fromARGB(224, 0, 0, 0),
                                    fit: BoxFit.scaleDown),
                              ),
                            )),
                      )
                    : FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 1,
                        child: Container(
                            decoration: const BoxDecoration(
                              gradient: SweepGradient(
                                colors: [Color(0xffc6e9ed), Color(0xffa3b2ff)],
                                stops: [0.7, 1],
                                center: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                    'assets/img/weight-scale.png',
                                    height: 50,
                                    width: 50,
                                    color: const Color.fromARGB(101, 0, 0, 0),
                                    fit: BoxFit.scaleDown),
                              ),
                            )),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
