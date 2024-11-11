import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class StylizowanePoleTekstowe extends StatelessWidget {
  const StylizowanePoleTekstowe(this.controler, this.icon, this.obscuretxt, {super.key});

  final controler;
  final IconData icon;
  final bool obscuretxt;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: TextField(
        obscureText: obscuretxt,
        controller: controler,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'inter'

        ),
         cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.titleColor,
          prefixIcon: Icon(icon, color: Colors.black,),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.black
            )
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2
            )
          ) 
        ),
      ),
    );
  }
}