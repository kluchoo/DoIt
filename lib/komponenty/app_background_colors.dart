import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class MainAppBackground extends StatelessWidget {
  const MainAppBackground(this.widget, {super.key});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          children: [
            const SizedBox(width: 50),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              color: AppColors.secondaryAccent,
            )),
            const SizedBox(width: 50),
          ],
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              width: 40,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0x20FFde59), Color(0x20FF914d)])),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 0,
            ),
            const Expanded(child: SizedBox()),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFFFde59),
                Color(0xFFFF914d),
                Color(0xFFFFde59),
                Color(0xFFFF914d),
                Color(0xFFFFde59),
                Color(0xFFFF914d),
                Color(0xFFFFde59),
              ], stops: [
                0,
                0.08,
                0.32,
                0.42,
                0.6,
                0.75,
                0.85
              ])),
            ),
          ],
        ),
        widget
      ],
    );
  }
}
