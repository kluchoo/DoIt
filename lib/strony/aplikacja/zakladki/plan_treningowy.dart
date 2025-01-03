import 'package:do_it/strony/aplikacja/zakladki/aystent.dart';
import 'package:do_it/strony/aplikacja/zakladki/plan.dart';
import 'package:do_it/strony/aplikacja/zakladki/pomiary.dart';
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
                "Plan treningowy",
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Pomiary()));
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
                "Pomiary Ciała",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Pogrubienie tekstu
                  color: Colors.black, // Czarny kolor czcionki
                  fontSize: 20, // Powiększenie czcionki
                ),
              ),
            ),
          )),

//trzeci przycisk
      //Lorem
      // Ipsum
      // is
      //simply
      //dummy
      // text
      //of
      //he
      // printing
      //and
      // typesetting i
      //ndustry.
      // Lorem
      // Ipsum
      // h
      //as
      // been
      // the
      //ndustry's
      // standard
      //dummy
      //text
      // ever
      // since
      // th
      //e
      //1500s,
      //when an
      // unknown
      //printer
      // took
      //a galley
      // of type
      //and s
      //crambled
      // it to
      // make a
      // type
      // specimen
      // book.
      //It has
      //survived
      // not
      // o
      //nly
      //five centuries,
      // but als
      //o
      //the
      // leap i
      //nto e
      //lectronic
      //typesetti
      //ng,
      // remaining
      //essentially
      // unchanged
      //. It was
      //popularised
      // in the 19
      //60s with
      // the
      // releas
      //e of
      //Letraset
      // sheets
      // containin
      //g Lorem
      // Ipsum pa

      //ssages
      //, and more r
      //ecentl
      //y wit
      //h deskt
      //op publishing s
      //oftware like A
      //ldus P
      //ageMaker
      // including
      //versions
      // of Lorem I
      // psum.

      StyledButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Aystent()));
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
                "Asystent sylwetki",
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
