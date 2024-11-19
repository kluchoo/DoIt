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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // final _loginControler = TextEditingController();
  // final _passwordControler = TextEditingController();

  // void dispose() {
  //   _loginControler.dispose();
  //   _passwordControler.dispose();
  //   super.dispose();
  // }

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
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // intro text
                        Center(child: TextField()),
                        SizedBox(
                          height: 16.0,
                        ),

                        // email address
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        //password

                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),

                        //error feedback

                        //submit button

                        StygiButon(
                          () async {},
                          ('Zarejestruj się'),
                        )
                      ],
                    ))

                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Row(
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                //           child: StylizowanyNaglowek('Adres e-mail'),
                //         ),
                //       ],
                //     ),
                //     StylizowanePoleTekstowe(_loginControler, Icons.mail, false),

                //     const Row(
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.fromLTRB(70, 25, 0, 0),
                //           child: StylizowanyNaglowek('Hasło'),
                //         ),
                //       ],
                //     ),
                //     StylizowanePoleTekstowe(
                //         _passwordControler, Icons.lock, true),

                //     PrzyciskZUkrytymTlem(rejestracja, 'Zarejestruj się!')

                //     // TextButton(onPressed: tescik, child: Text('test')),
                //   ],
                // ),
              ],
            )
          ],
        ));
  }
}
