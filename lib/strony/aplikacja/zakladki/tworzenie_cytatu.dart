import 'dart:ui';

import 'package:do_it/komponenty/text.dart';
import 'package:do_it/models/quote_model.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TworzenieCytatu extends ConsumerStatefulWidget {
  TworzenieCytatu({super.key});

  @override
  _TworzenieCytatuState createState() => _TworzenieCytatuState();
}

class _TworzenieCytatuState extends ConsumerState<TworzenieCytatu> {
  final TextEditingController quoteController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  DateTime date = DateTime.now();
  String ownerId = '';
  @override
  Widget build(BuildContext context) {
    autorController.text = ref.watch(appUserProvider).name;
    String ownerId = ref.watch(appUserProvider).uid;

    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: const StylizowanyNaglowek('Tworzenie cytatu'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: StylizowanyText('Cytat:'),
                ),
                TextFormField(
                  maxLines: null,
                  minLines: 5,
                  controller: quoteController,
                  obscureText: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.titleColor,
                      prefixIcon: const Icon(
                        Icons.format_quote,
                        color: Colors.black,
                      ),
                      suffixIcon: const Icon(
                        Icons.format_quote,
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 2))),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                      height: 1.5), // Adjust the height of the text
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: StylizowanyText('Autor:'),
                ),
                TextFormField(
                  controller: autorController,
                  obscureText: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.titleColor,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 2))),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: StylizowanyText('Data:'),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.titleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${date.toUtc().day}.${date.toUtc().month}.${date.toUtc().year}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      IconButton.outlined(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            side: WidgetStatePropertyAll(
                              BorderSide(color: Colors.black),
                            ),
                            iconColor: WidgetStatePropertyAll(Colors.black),
                            elevation: WidgetStatePropertyAll(0),
                          ),
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(-4000),
                              lastDate: DateTime(2025),
                            );

                            if (selectedDate != null) {
                              setState(() {
                                date =
                                    selectedDate.add(const Duration(days: 1));
                              });
                            }
                          },
                          icon: const Icon(Icons.access_time_rounded))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                IconButton.filled(
                  style: ButtonStyle(
                    iconSize: const WidgetStatePropertyAll(40),
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.primaryColor),
                    iconColor: const WidgetStatePropertyAll(Colors.black),
                    elevation: const WidgetStatePropertyAll(0),
                  ),
                  onPressed: () async {
                    final newQuote = Quote(
                      ownerId: ownerId, //id użytkownika
                      date: date,
                      quote: quoteController
                          .text, //treść cytatu pobierana z kontrolera
                      author: autorController.text,
                      likes: 0,
                    );
                    ref.read(quotesProvider).addQuote(newQuote);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ));
  }
}
