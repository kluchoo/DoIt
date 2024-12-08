import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String uid;
  final String email = "null";
  final String name = "null";
  final Uint8List? photo = null;

  AppUser({required this.uid});
}
