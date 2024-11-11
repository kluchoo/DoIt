import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

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
            child: GestureDetector(
              onTap: () =>
                  widget.onItemSelected(0), // Wywołanie funkcji przy kliknięciu
              child: AnimatedSwitcher(
                duration:
                    const Duration(milliseconds: 300), // Animacja przejścia
                child: widget.chosenIndex == 0
                    ? FractionallySizedBox(
                        key: ValueKey<int>(0), // Unikalny klucz dla animacji
                        widthFactor: 0.8,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: SweepGradient(
                              colors: [Color(0xffffde59), Color(0xfffc466b)],
                              stops: [0.2, 0.7],
                              center: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      )
                    : FractionallySizedBox(
                        key: ValueKey<int>(1), // Unikalny klucz dla animacji
                        widthFactor: 0.7,
                        heightFactor: 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.element,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  widget.onItemSelected(1), // Wywołanie funkcji przy kliknięciu
              child: AnimatedSwitcher(
                duration:
                    const Duration(milliseconds: 300), // Animacja przejścia
                child: widget.chosenIndex == 1
                    ? FractionallySizedBox(
                        key: ValueKey<int>(2), // Unikalny klucz dla animacji
                        widthFactor: 0.8,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: SweepGradient(
                              colors: [Color(0xffffde59), Color(0xfffc466b)],
                              stops: [0.2, 0.7],
                              center: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      )
                    : FractionallySizedBox(
                        key: ValueKey<int>(3), // Unikalny klucz dla animacji
                        widthFactor: 0.7,
                        heightFactor: 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.element,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  widget.onItemSelected(2), // Wywołanie funkcji przy kliknięciu
              child: AnimatedSwitcher(
                duration:
                    const Duration(milliseconds: 300), // Animacja przejścia
                child: widget.chosenIndex == 2
                    ? FractionallySizedBox(
                        key: ValueKey<int>(4), // Unikalny klucz dla animacji
                        widthFactor: 0.8,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: SweepGradient(
                              colors: [Color(0xffffde59), Color(0xfffc466b)],
                              stops: [0.2, 0.7],
                              center: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      )
                    : FractionallySizedBox(
                        key: ValueKey<int>(5), // Unikalny klucz dla animacji
                        widthFactor: 0.7,
                        heightFactor: 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.element,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
