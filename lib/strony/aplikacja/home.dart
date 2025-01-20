import 'dart:typed_data';

import 'package:do_it/komponenty/app_background_colors.dart';
import 'package:do_it/komponenty/botom_navigation_bar.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/strony/aplikacja/progressDocumentations.dart';
import 'package:do_it/strony/aplikacja/zakladki/cytaty.dart';
import 'package:do_it/strony/aplikacja/zakladki/plan_treningowy.dart';
import 'package:do_it/strony/aplikacja/zakladki/profil_uzytkownika.dart';
import 'package:do_it/theme.dart';
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
  bool isScreenDimmed = false;

  @override
  void initState() {
    super.initState();
    // Opóźniamy inicjalizację do następnej klatki
    Future.microtask(() async {
      debugPrint('Inicjalizacja w Home...');
      final user = ref.watch(appUserProvider);
      try {
        await user.fetchUserData();
        await user.fetchUserAuthData();
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
    ref.read(progressProvider).fetchProgress(ref);
    final profileImage = user.photo;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: Stack(children: [
            Container(
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
                      centerTitle: false,
                      title: Text(
                        title,
                        style: GoogleFonts.openSans(
                          fontSize: 22,
                          letterSpacing: 1,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => GestureDetector(
                        onTap: () {
                          debugPrint('Otwieranie szuflady');
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: OverflowBox(
                          maxWidth: 135,
                          maxHeight: 150,
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryAccent,
                              gradient: const LinearGradient(colors: [
                                Color(0xFFc6e9ed),
                                Color.fromARGB(255, 144, 184, 189),
                                Color(0xFFc6e9ed)
                              ], stops: [
                                0,
                                0.5,
                                1
                              ]),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 35, 25, 25),
                              child: OverflowBox(
                                maxHeight: 90,
                                maxWidth: 90,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: profileImage != null
                                        ? Image.memory(
                                            profileImage,
                                            fit: BoxFit.cover,
                                            scale: 0.5,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ]),
        ),
        endDrawer: Drawer(
            backgroundColor: AppColors.secondaryAccent.withOpacity(0.9),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  title: const StylizowanyNaglowek('Profil użytkownika'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileSettingsPage()));
                  },
                ),
                ListTile(
                  title:
                      const StylizowanyNaglowek('Automatyczne przyciemnianie'),
                  trailing: Switch(
                    value: isScreenDimmed,
                    onChanged: (value) {
                      setState(() {
                        isScreenDimmed = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: StylizowanyNaglowek(
                    'Wyloguj',
                  ),
                  onTap: () {
                    ref.read(appUserProvider).logOut();
                  },
                ),
              ],
            )),
        body: MainAppBackground(Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: IndexedStack(
                index: index,
                children: const [
                  Quotes(), // Widok dla index == 0
                  Center(
                    child: Progressdocumentations(),
                  ), // Widok dla index == 1
                  Center(
                    child: PlanTreningowy(),
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
