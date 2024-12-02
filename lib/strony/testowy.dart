import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Testy extends ConsumerStatefulWidget {
  Testy({super.key});

  @override
  ConsumerState<Testy> createState() => _TestyState();
}

class _TestyState extends ConsumerState<Testy> {
  Image img = Image.asset('assets/img/doititransparent.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(image: img.image),
            TextButton(
                onPressed: () async {
                  await updateProfileImg(ref, 'assets/img/doit.png');
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

Future<void> updateProfileImg(WidgetRef ref, String img) async {
  String base64Image = await encode(img);
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
