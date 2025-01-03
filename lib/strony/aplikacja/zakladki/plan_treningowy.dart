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
            minimumSize:
                MaterialStateProperty.all(Size(150, 50)), // Zmniejsz szerokość
          ),
          child: Ink(
            decoration: BoxDecoration(
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: const Text(
                "adam gej",
                style: TextStyle(
                    fontWeight: FontWeight.bold), // Pogrubienie tekstu
              ),
            ),
          )),
    ]);
  }
}
