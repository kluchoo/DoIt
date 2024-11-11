import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StylizowanyText extends StatelessWidget {
  const StylizowanyText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.inter(
      textStyle: Theme.of(context).textTheme.bodyMedium
    ));
  }
}
class StylizowanyNaglowek extends StatelessWidget {
  const StylizowanyNaglowek(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.inter(
      textStyle: Theme.of(context).textTheme.headlineMedium
    ));
  }
}
class StylizowanyTytul extends StatelessWidget {
  const StylizowanyTytul(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.inter(
      textStyle: Theme.of(context).textTheme.titleMedium
    ));
  }
}