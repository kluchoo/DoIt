import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class MainAppBackground extends StatelessWidget {
  const MainAppBackground(this.widget ,{super.key});

  final Widget widget;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: [
          Row(
            children: [
              const SizedBox(width: 50),
              Expanded(child: Container(color: AppColors.secondaryAccent,)),
              const SizedBox(width: 50),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                width: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: 
                      [Color(0xFFFFde59),
                      Color(0xFFFF914d)]
                    )
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Column(
            children: [
              Container(
                height: 20,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: 
                      [
                        Color(0xFFFFde59),
                        Color(0xFFFFde59),
                        Color(0xFFFF914d),
                        Color(0xFFFF914d)
                      ],
                      stops: [0, 0.42, 0.58 ,1]
                    )
                ),
              ),

              const Expanded(child: SizedBox()),

              Container(
                height: 15,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: 
                      [
                        Color(0xFFFFde59),
                        Color(0xFFFFde59),
                        Color(0xFFFF914d),
                        Color(0xFFFF914d)
                      ],
                      stops: [0, 0.4, 0.6 ,1]
                    )
                ),
              ),
            ],
          ),
          widget
        ],
      );
  }
}