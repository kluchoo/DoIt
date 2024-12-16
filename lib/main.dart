import 'package:do_it/models/app_user.dart';
import 'package:do_it/services/auth_service.dart';
import 'package:do_it/strony/autoryzacja/ponowne_logowanie.dart';
import 'package:do_it/strony/autoryzacja/welcome.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppUser? user = AuthService.getCurrentUser();
  if (user != null) {
    debugPrint('User is already logged in ' + user.email);
    runApp(
      const ProviderScope(
        child: SessionLogin(),
      ),
    );
  } else {
    debugPrint('User is not logged in');
    runApp(
      const ProviderScope(
        child: NoSessionLogin(),
      ),
    );
  }
}

class SessionLogin extends StatelessWidget {
  const SessionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: primaryTheme,
      home: const ReLogIn(),
    );
  }
}

class NoSessionLogin extends StatelessWidget {
  const NoSessionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: primaryTheme,
      home: const WelcomeScreen(),
    );
  }
}
