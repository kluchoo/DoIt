import 'package:do_it/models/app_user.dart';
import 'package:do_it/services/auth_service.dart';
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

  AppUser user = AuthService.getCurrentUser()!;
  if (user != null) {
    debugPrint('User is already logged in ' + user.email);
  }

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: primaryTheme,
      home: const WelcomeScreen(),
    );
  }
}
