import 'package:do_it/komponenty/cytat.dart';
import 'package:do_it/komponenty/text.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TworzenieCytatu extends StatelessWidget {
  const TworzenieCytatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: const StylizowanyNaglowek('Tworzenie cytatu'),
        ),
        body: IconButton.filled(
            style: ButtonStyle(
                iconSize: const WidgetStatePropertyAll(40),
                backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
                iconColor: const WidgetStatePropertyAll(Colors.black),
                elevation: const WidgetStatePropertyAll(0)),
            onPressed: () async {
              final newQuote = Quote(
                ownerId: 'dasdas', //id użytkownika
                date: '16.11.2024',
                quote:
                    'W tym właśnie punkcie język potoczny rezygnuje i wychodzi na piwo.',
                author: "Nieznany autor",
                likes: 100,
              );
              Provider.of<QuotesModel>(context, listen: false)
                  .addQuote(newQuote);
            },
            icon: const Icon(Icons.add)));
  }
}
