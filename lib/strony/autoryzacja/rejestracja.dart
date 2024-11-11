import 'package:do_it/komponenty/text.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class Rejestracja extends StatefulWidget {
  const Rejestracja({super.key});

  @override
  State<Rejestracja> createState() => _RejestracjaState();
}

class _RejestracjaState extends State<Rejestracja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StylizowanyNaglowek('Rejestracja'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            children: [
              const SizedBox(width: 50),
              Expanded(child: Container(color: AppColors.secondaryAccent,)),
              const SizedBox(width: 50),
            ],
          ),
          
        ]
      )
    );
  }
}