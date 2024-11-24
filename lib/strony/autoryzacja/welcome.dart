import 'package:do_it/komponenty/text.dart';
import 'package:do_it/strony/autoryzacja/logowanie.dart';
import 'package:do_it/strony/autoryzacja/rejestracja.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isSignUpForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 130),
                    child: Center(
                      child: Image.asset(
                        'assets/img/doit.png',
                        width: 200,
                      ),
                    ),
                  ),
                  // sign up screen
                  if (isSignUpForm)
                    Column(children: [
                      const SignInForm(),
                      const StylizowanyText('Masz już konto?'),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSignUpForm = false;
                          });
                        },
                        child:
                            Text('Zaloguj się', style: GoogleFonts.poppins()),
                      )
                    ]),

                  // sign in screen
                  if (!isSignUpForm)
                    Column(children: [
                      const SignUpForm(),
                      Text(
                        'Potrzebujesz konta?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                          textStyle: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSignUpForm = true;
                          });
                        },
                        child: Text('Zarejestruj się',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w800,
                            )),
                      )
                    ]),
                ])),
      ),
    );
  }
}