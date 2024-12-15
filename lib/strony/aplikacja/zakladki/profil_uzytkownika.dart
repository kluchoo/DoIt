import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/komponenty/styled_button.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/strony/aplikacja/zakladki/camera.dart';
import 'package:do_it/strony/autoryzacja/welcome.dart';
import 'package:do_it/strony/testowy.dart';
import 'package:do_it/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSettingsPage extends ConsumerStatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  ConsumerState<ProfileSettingsPage> createState() =>
      _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends ConsumerState<ProfileSettingsPage> {
  late Uint8List? profileImage;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = ref.read(appUserProvider).name;
    profileImage = ref.read(appUserProvider).photo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          TextButton(
            onPressed: () async {
              // TODO: Implement save functionality
              if (profileImage != ref.read(appUserProvider).photo) {
                await updateProfileImg(ref, profileImage);
                ref.read(appUserProvider).fetchUserData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Zapisano zmiany')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Najpierw wybierz zdjęcie')),
                );
              }
            },
            child: const StylizowanyText('Zapisz', color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey.withOpacity(0.1),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const StylizowanyTytul(
                      'Zdjęcie profilowe',
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    backgroundColor: AppColors.secondaryAccent,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.memory(
                                          width: 400,
                                          profileImage!,
                                          fit: BoxFit.fitWidth,
                                          scale: 1,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            debugPrint(
                                                'Błąd ładowania zdjęcia: $error');
                                            return const Icon(
                                              Icons.person,
                                              size: 85,
                                              color: Colors.white,
                                            );
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const StylizowanyNaglowek(
                                            'Zamknij',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: ClipOval(
                          child: profileImage != null
                              ? Image.memory(
                                  profileImage!,
                                  fit: BoxFit.fitWidth,
                                  scale: 1,
                                  errorBuilder: (context, error, stackTrace) {
                                    debugPrint(
                                        'Błąd ładowania zdjęcia: $error');
                                    return const Icon(
                                      Icons.person,
                                      size: 85,
                                      color: Colors.white,
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 85,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.black.withOpacity(0.1)),
                                ),
                                child: const StylizowanyText(
                                  'Zrób zdjęcie',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () async {
                                  final XFile? picture =
                                      await Navigator.push<XFile>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Camera(),
                                    ),
                                  );

                                  if (picture != null) {
                                    final Uint8List imageBytes =
                                        await picture.readAsBytes();
                                    setState(() {
                                      profileImage = imageBytes;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(width: 16),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.black.withOpacity(0.1)),
                                ),
                                child: const StylizowanyText(
                                  'Wybierz plik',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () async {
                                  try {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      withData: true,
                                    );

                                    if (result != null &&
                                        result.files.isNotEmpty) {
                                      Uint8List? fileBytes =
                                          result.files.first.bytes;
                                      if (fileBytes != null) {
                                        setState(() {
                                          profileImage = fileBytes;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Nie udało się wczytać pliku')),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Błąd: ${e.toString()}')),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                  color: Colors.grey.withOpacity(0.1),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      StylizowanyTytul('Nazwa konta', color: Colors.white),
                      const SizedBox(height: 16),
                      TextField(
                        enabled: false,
                        onTap: () {
                          nameController.text = '';
                        },
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        onTapOutside: (event) => {
                          FocusScope.of(context).unfocus(),
                          if (nameController.text == '')
                            nameController.text = ref.read(appUserProvider).name
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          prefixStyle:
                              TextStyle(color: Colors.white, fontSize: 12),
                          hintStyle: TextStyle(color: Colors.white),
                          floatingLabelStyle: TextStyle(color: Colors.white),
                          fillColor: Color.fromARGB(17, 255, 255, 255),
                          labelText: "Nazwa konta:",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 210, 32, 255)),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        onChanged: (value) {},
                      )
                    ],
                  )),
              StyledButton(
                  onPressed: () {
                    ref.read(appUserProvider).logOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()));
                  },
                  child: const StylizowanyNaglowek('Wyloguj',
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> updateProfileImg(WidgetRef ref, Uint8List? imageBytes) async {
  debugPrint(ref.read(appUserProvider).uid);
  String uid = ref.read(appUserProvider).uid;
  String base64Image = encodeBytes(imageBytes!);
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({'profileImg': base64Image.toString()});
}
