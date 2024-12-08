import 'package:do_it/strony/aplikacja/home.dart';
import 'package:do_it/strony/aplikacja/zakladki/camera.dart';
import 'package:do_it/strony/testowy.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
        child: MaterialApp(
      theme: primaryTheme,
      home: Home(),
    )),
  );
}
