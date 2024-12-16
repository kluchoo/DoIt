import 'package:do_it/komponenty/styled_button.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/services/auth_service.dart';
import 'package:do_it/services/local_auth_service.dart';
import 'package:do_it/strony/aplikacja/home.dart';
import 'package:do_it/strony/autoryzacja/welcome.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ReLogIn extends ConsumerStatefulWidget {
  const ReLogIn({super.key});

  @override
  ConsumerState<ReLogIn> createState() => _ReLogInState();
}

Future<void> changeAccount(
  BuildContext context,
  WidgetRef ref,
) async {
  ref.read(appUserProvider).logOut();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
}

class _ReLogInState extends ConsumerState<ReLogIn> {
  @override
  @override
  void initState() {
    super.initState();
    final currentUser = AuthService.getCurrentUser();
    if (currentUser != null) {
      Future.microtask(() {
        ref.read(appUserProvider.notifier).update(currentUser);
        ref.read(appUserProvider.notifier).fetchUserData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(appUserProvider);
    debugPrint('User: ${user.photo}');
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _passwordController = TextEditingController();

    String? _errorFeedback;
    bool authenticated = false;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Center(
                  child: Image.asset(
                    'assets/img/doit.png',
                    width: 200,
                  ),
                ),
              ),
              Center(
                child: ClipOval(
                  child: user.photo != null
                      ? Image.memory(
                          user.photo!,
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                          scale: 0.5,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Błąd ładowania zdjęcia: $error');
                            return const Icon(
                              Icons.person,
                              size: 65,
                              color: Colors.white,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person,
                          size: 65,
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StylizowanyText('Witaj ponownie '),
                  StylizowanyNaglowek(user.name,
                      color: const Color.fromARGB(255, 78, 174, 253)),
                  const StylizowanyText('!'),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.titleColor,
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(
                                  color: AppColors.primaryColor, width: 2))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Podaj hasło';
                        }
                        if (value.length < 8) {
                          return 'Nieprawidłowe hasło';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    StyledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _errorFeedback = null;
                          });

                          final email = user.email;
                          final password = _passwordController.text.trim();

                          final signedInUser =
                              await AuthService.signIn(email, password);

                          // error feedback
                          if (signedInUser == null) {
                            setState(() {
                              _errorFeedback = 'Nieprawidłowe dane logowania';
                            });
                          } else {
                            ref.read(appUserProvider).uid = signedInUser.uid;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const Home()));

                            // navigate to home on success
                          }
                        }
                      },
                      child: const StyledButtonText('Zaloguj się'),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('lub'),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  final authenticate = await LocalAuth.authenticate();
                  setState(() {
                    authenticated = authenticate;
                  });
                  if (authenticated) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }
                },
                child: Icon(
                  Icons.fingerprint,
                  size: 75,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 45.0,
              ),
              const StylizowanyText('Chcesz zmienić konto?'),
              TextButton(
                onPressed: () => changeAccount(context, ref),
                child: Text('Zmień', style: GoogleFonts.poppins()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
