import 'package:do_it/komponenty/styled_button.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/services/auth_service.dart';
import 'package:do_it/services/local_auth_service.dart';
import 'package:do_it/strony/aplikacja/home.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorFeedback;
  bool authenticated = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // intro text

            Center(
                child: Text('Logowanie',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                    ))),
            const SizedBox(height: 12.0),

            // email address
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.titleColor,
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Podaj email';
                  }
                  return null;
                }),

            const SizedBox(height: 16.0),

            // password
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
                        borderRadius: BorderRadius.all(Radius.circular(50)),
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
                    return 'Hasło musi mieć co najmniej 8 znaków';
                  }
                  return null;
                }),

            const SizedBox(height: 16.0),

            // error feedback
            if (_errorFeedback != null)
              Text(
                _errorFeedback!,
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 16.0),

            // logowanie z palca

            TextButton(
              onPressed: () async {
                final authenticate = await LocalAuth.authenticate();
                setState(() {
                  authenticated = authenticate;
                });
              },
              child: Text('Odcisk Palca',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800,
                  )),
            ),

            // submit button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });

                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  final user = await AuthService.signIn(email, password);

                  // error feedback
                  if (user == null) {
                    setState(() {
                      _errorFeedback = 'Nieprawidłowe dane logowania';
                    });
                  } else {
                    ref.read(appUserProvider).uid = user.uid;
                    debugPrint('User: ${ref.watch(appUserProvider).uid}');
                    // debugPrint('Zalogowano jako ${user.uid}');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => const Home()));

                    // navigate to home on success
                  }
                }
              },
              child: const StyledButtonText('Zaloguj się'),
            ),
          ],
        ),
      ),
    );
  }
}
