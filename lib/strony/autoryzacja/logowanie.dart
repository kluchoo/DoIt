import 'package:do_it/komponenty/styled_button.dart';
import 'package:do_it/komponenty/styled_text.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2))),
            ),
            const SizedBox(height: 16.0),

            // password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.titleColor,
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2))),
            ),
            const SizedBox(height: 16.0),

            // error feedback

            // submit button
            StyledButton(
              onPressed: () async {},
              child: const StyledButtonText('Zaloguj się'),
            ),
          ],
        ),
      ),
    );
  }
}
