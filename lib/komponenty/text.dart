import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StylizowanyText extends StatelessWidget {
  const StylizowanyText(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.bodyMedium,
            color: color ?? AppColors.titleColor));
  }
}

class StylizowanyNaglowek extends StatelessWidget {
  const StylizowanyNaglowek(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            color: color ?? AppColors.titleColor));
  }
}

class StylizowanyTytul extends StatelessWidget {
  const StylizowanyTytul(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.titleMedium,
            color: color ?? AppColors.titleColor));
  }
}
