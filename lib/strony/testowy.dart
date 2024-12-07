import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'aplikacja/zakladki/camera.dart';

class Testy extends ConsumerStatefulWidget {
  const Testy({super.key});

  @override
  ConsumerState<Testy> createState() => _TestyState();
}

class _TestyState extends ConsumerState<Testy> {
  Image img = Image.asset('assets/img/doititransparent.png');
  Uint8List? pickedImageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: img.image,
              width: 800,
            ),
            if (pickedImageBytes != null)
              Image.memory(pickedImageBytes!, height: 100),
            TextButton.icon(
                onPressed: () async {
                  final XFile? picture = await Navigator.push<XFile>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Camera(),
                    ),
                  );

                  if (picture != null) {
                    // Konwertuj XFile na Uint8List
                    final Uint8List imageBytes = await picture.readAsBytes();

                    setState(() {
                      pickedImageBytes = imageBytes;
                    });
                  }
                },
                label: const Text('Zrób zdjęcie'),
                icon: const Icon(Icons.image)),
            TextButton(
              onPressed: () async {
                try {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    withData: true,
                  );

                  if (result != null && result.files.isNotEmpty) {
                    Uint8List? fileBytes = result.files.first.bytes;
                    if (fileBytes != null) {
                      setState(() {
                        pickedImageBytes = fileBytes;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Nie udało się wczytać pliku')),
                      );
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Błąd: ${e.toString()}')),
                  );
                }
              },
              child: const Text('Wybierz plik'),
            ),
            TextButton(
                onPressed: () async {
                  if (pickedImageBytes != null) {
                    await updateProfileImg(ref, pickedImageBytes!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Najpierw wybierz zdjęcie')),
                    );
                  }
                },
                child: const Text('wyślij do bazy danych')),
            TextButton(
              onPressed: () async {
                String base64String = await encode('assets/img/doit.png');
                Uint8List imageBytes = await decode(base64String);
                setState(() {
                  img = Image.memory(imageBytes);
                });
              },
              child: const Text('dekoduj base64'),
            ),
            TextButton(
                onPressed: () async {
                  Image img = await downloadProfileImg(ref);
                  setState(() {
                    this.img = img;
                  });
                },
                child: const Text('pobierz z bazy danych')),
          ],
        ),
      ),
    );
  }
}

// Nowa funkcja do kodowania bytes na base64
String encodeBytes(Uint8List bytes) {
  return base64Encode(bytes);
}

Future<String> encode(String img) async {
  final ByteData bytes = await rootBundle.load(img);
  final List<int> bytesList = bytes.buffer.asUint8List();
  final String base64Image = base64Encode(bytesList);
  return base64Image;
}

Future<Uint8List> decode(String base64String) async {
  Uint8List decodedBytes = base64Decode(base64String);
  return decodedBytes;
}

// Zmodyfikowana funkcja updateProfileImg
Future<void> updateProfileImg(WidgetRef ref, Uint8List imageBytes) async {
  String base64Image = encodeBytes(imageBytes);
  await FirebaseFirestore.instance
      .collection('users')
      .doc(ref.read(appUserProvider).uid)
      .update({'profileImg': base64Image});
}

Future<Image> downloadProfileImg(WidgetRef ref) async {
  DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(ref.read(appUserProvider).uid)
      .get();
  String base64Image = doc.data()?['profileImg'];
  Uint8List imageBytes = await decode(base64Image);
  Image img = Image.memory(imageBytes);
  return img;
}
