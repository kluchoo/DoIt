import 'package:do_it/komponenty/text.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/services/auth_service.dart';
import 'package:do_it/strony/autoryzacja/welcome.dart';
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
