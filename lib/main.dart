import 'package:do_it/komponenty/cytat.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/strony/aplikacja/home.dart';
import 'package:do_it/strony/autoryzacja/logowanie.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TitleProvider()),
          ChangeNotifierProvider(create: (context) => QuotesModel())
        ],
        child: MaterialApp(
          theme: primaryTheme,
          home: const Logowanie(),
        )),
  );
}
