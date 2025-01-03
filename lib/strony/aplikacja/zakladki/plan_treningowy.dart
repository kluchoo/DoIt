import 'package:do_it/strony/aplikacja/zakladki/plan.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonStyle style;
  final Widget child;

  const StyledButton({
    required this.onPressed,
    required this.style,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}

class PlanTreningowy extends StatelessWidget {
  const PlanTreningowy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StyledButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Plan()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor:
                MaterialStateProperty.all(Colors.black.withOpacity(0.2)),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(
                Size(200, 70)), // Zwiększ rozmiar przycisku
            maximumSize: MaterialStateProperty.all(
                Size(250, 70)), // Ogranicz długość przycisku
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .scaffoldBackgroundColor, // Jednolite tło zgodne z tłem strony
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
              gradient: const SweepGradient(
                colors: [Color(0xffffde59), Color(0xfffc466b)],
                stops: [0.2, 0.7],
                center: Alignment.topRight,
              ),
              borderRadius:
                  BorderRadius.circular(30), // Gładkie rogi z obu stron
            ),
            child: Center(
              child: const Text(
                "adam gej",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Pogrubienie tekstu
                  color: Colors.black, // Czarny kolor czcionki
                  fontSize: 20, // Powiększenie czcionki
                ),
              ),
            ),
          )),
      StyledButton(
          onPressed: () {
            // Navigator pozostaw pusty
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor:
                MaterialStateProperty.all(Colors.black.withOpacity(0.2)),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(
                Size(200, 70)), // Zwiększ rozmiar przycisku
            maximumSize: MaterialStateProperty.all(
                Size(250, 70)), // Ogranicz długość przycisku
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .scaffoldBackgroundColor, // Jednolite tło zgodne z tłem strony
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
              gradient: const SweepGradient(
                colors: [Color(0xffffde59), Color(0xfffc466b)],
                stops: [0.2, 0.7],
                center: Alignment.topRight,
              ),
              borderRadius:
                  BorderRadius.circular(30), // Gładkie rogi z obu stron
            ),
            child: Center(
              child: const Text(
                "buldog gej",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Pogrubienie tekstu
                  color: Colors.black, // Czarny kolor czcionki
                  fontSize: 20, // Powiększenie czcionki
                ),
              ),
            ),
          )),
    ]);
  }
}
