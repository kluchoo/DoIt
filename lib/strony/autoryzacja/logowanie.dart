import 'package:do_it/komponenty/buttons.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/komponenty/textfield.dart';
import 'package:do_it/strony/autoryzacja/rejestracja.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class Logowanie extends StatefulWidget {
  const Logowanie({super.key});

  @override
  State<Logowanie> createState() => _LogowanieState();
}

class _LogowanieState extends State<Logowanie> {
  final _loginControler = TextEditingController();
  final _passwordControler = TextEditingController();

  void dispose() {
    _loginControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  void tescik() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        closeIconColor: Colors.white,
        showCloseIcon: true,
        content: Container(
          child: const Text(
            'test',
            style: TextStyle(color: Colors.white),
          ),
        )));
    return;
  }

  void rejestracja() {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const Rejestracja()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shadowColor: Colors.black,
          title: const StylizowanyNaglowek('Logowanie'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Row(
              children: [
                const SizedBox(width: 50),
                Expanded(
                    child: Container(
                  color: AppColors.secondaryAccent,
                )),
                const SizedBox(width: 50),
              ],
            ),
            Column(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                          child: StylizowanyNaglowek('Adres e-mail'),
                        ),
                      ],
                    ),
                    StylizowanePoleTekstowe(_loginControler, Icons.mail, false),

                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 25, 0, 0),
                          child: StylizowanyNaglowek('Hasło'),
                        ),
                      ],
                    ),
                    StylizowanePoleTekstowe(
                        _passwordControler, Icons.lock, true),

                    TextButton(onPressed: tescik, child: const Text('tescik')),
                    const SizedBox(
                      height: 150,
                    ),

                    PrzyciskZUkrytymTlem(rejestracja, 'Zarejestruj się!')

                    // TextButton(onPressed: tescik, child: Text('test')),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
