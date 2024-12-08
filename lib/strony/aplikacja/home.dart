import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:do_it/komponenty/app_background_colors.dart';
import 'package:do_it/komponenty/botom_navigation_bar.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/strony/aplikacja/zakladki/camera.dart';
import 'package:do_it/strony/aplikacja/zakladki/cytaty.dart';
import 'package:do_it/strony/aplikacja/zakladki/profil_uzytkownika.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int index = 0;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    // Opóźniamy inicjalizację do następnej klatki
    Future.microtask(() async {
      debugPrint('Inicjalizacja w Home...');
      final user = ref.read(appUserProvider);
      user.uid = "BuAn4rNn57gOkLu0MqgrImjgAMk1";
      try {
        await user.fetchUserData();
        debugPrint('Zakończono ładowanie danych użytkownika');
      } catch (e) {
        debugPrint('Błąd podczas inicjalizacji: $e');
      }
    });
  }

  void updateIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = ref.watch(titleProvider).title;
    final user = ref.watch(appUserProvider);
    final profileImage = user.photo;

    // Debugowanie
    if (profileImage != null) {
      debugPrint('Zdjęcie jest dostępne, długość: ${profileImage}');
    } else {
      debugPrint('Brak zdjęcia profilowego');
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFFF914d),
                Color(0xFFFFde59),
                Color(0xFFFFde59),
                Color(0xFFFF914d)
              ], stops: [
                0,
                0.4,
                0.6,
                1
              ])),
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                  ),
                  Center(
                      child: Text(
                    title,
                    style: GoogleFonts.openSans(
                      fontSize: 22,
                      letterSpacing: 1,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w800,
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileSettingsPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipOval(
                            child: profileImage != null
                                ? Image.memory(
                                    profileImage,
                                    fit: BoxFit.cover,
                                    scale: 0.5,
                                    errorBuilder: (context, error, stackTrace) {
                                      debugPrint(
                                          'Błąd ładowania zdjęcia: $error');
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
                      ),
                    ],
                  )
                ],
              )),
        ),
        body: MainAppBackground(Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: IndexedStack(
                index: index,
                children: const [
                  Quotes(), // Widok dla index == 0
                  Center(
                    child: Text('data2'),
                  ), // Widok dla index == 1
                  Center(
                    child: Text('data3'),
                  ), // Widok dla index == 2
                ],
              ),
            ),
            Column(
              children: [
                const Expanded(child: SizedBox()),
                CustomBottomNavigationBar(
                  chosenIndex: index,
                  onItemSelected: updateIndex, // Przekazywanie funkcji
                )
              ],
            )
          ],
        )));
  }
}
