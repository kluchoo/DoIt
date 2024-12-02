import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Testy extends StatefulWidget {
  const Testy({super.key});

  @override
  State<Testy> createState() => _TestyState();
}

class _TestyState extends State<Testy> {
  Image img = Image.asset('assets/img/doititransparent.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(image: img.image),
            TextButton(
                onPressed: () {
                  Encode('assets/img/doit.png');
                },
                child: const Text('konwertuj na base64')),
            TextButton(
              onPressed: () async {
                String base64String = await Encode('assets/img/doit.png');
                Uint8List imageBytes = await Decode(base64String);
                setState(() {
                  img = Image.memory(imageBytes);
                });
              },
              child: const Text('dekoduj base64'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> Encode(String img) async {
  final ByteData bytes = await rootBundle.load(img);
  final List<int> bytesList = bytes.buffer.asUint8List();
  final String base64Image = base64Encode(bytesList);
  return base64Image;
}

Future<Uint8List> Decode(String base64String) async {
  Uint8List decodedBytes = base64Decode(base64String);
  return decodedBytes;
}
