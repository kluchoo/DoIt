import 'package:do_it/komponenty/styled_button.dart';
import 'package:do_it/strony/aplikacja/zakladki/plan.dart';
import 'package:flutter/material.dart';

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
          child: const Text("adam gej")),
    ]);
  }
}
