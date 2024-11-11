import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrzyciskZUkrytymTlem extends StatelessWidget {
  const PrzyciskZUkrytymTlem(this.onPressed, this.text, {super.key});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text,
    style: GoogleFonts.inter(
      textStyle: Theme.of(context).textTheme.titleMedium,
      color: AppColors.primaryColor
    ),
    ));
  }
}