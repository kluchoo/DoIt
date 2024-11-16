import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/strony/aplikacja/home.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TitleProvider()),
        ],
        child: MaterialApp(
          theme: primaryTheme,
          home: const Home(),
        )),
  );
}
