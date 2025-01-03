import 'package:do_it/komponenty/styled_button.dart';
import 'package:flutter/material.dart';

class PlanTreningowy extends StatelessWidget {
  const PlanTreningowy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StyledButton(onPressed: () {}, child: Text("Adam gej")),
    ]);
  }
}
