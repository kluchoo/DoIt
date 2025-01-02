import 'package:do_it/models/progress_model.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/providers/providers.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif/gif.dart';
import 'dart:async';

class Progressdocumentations extends ConsumerStatefulWidget {
  const Progressdocumentations({super.key});

  @override
  ConsumerState<Progressdocumentations> createState() =>
      _ProgressdocumentationsState();
}

class _ProgressdocumentationsState extends ConsumerState<Progressdocumentations>
    with TickerProviderStateMixin {
  int seria = 0;
  late GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);
    super.initState();
    _initializeSeria();
  }

  Future<void> _initializeSeria() async {
    seria = await ref.read(appUserProvider).dayStrikeUpdate();
    // ref.read(progressProvider).updateProgress(progressData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ProgressNotifier progressNotifier = ref.watch(progressProvider);

    return Column(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: List.from([
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 98, 36)
                                .withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 1000,
                            offset: Offset.fromDirection(5),
                          ),
                        ]),
                      ),
                      child: Center(
                        child: Gif(
                          controller: controller,
                          image: const AssetImage("assets/img/fire.gif"),
                          autostart: Autostart.loop,
                          duration: const Duration(milliseconds: 3000),
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 170, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(seria.toString(),
                            style: TextStyle(
                                fontSize: 35,
                                color: seria < 10
                                    ? Colors.white
                                    : seria < 20
                                        ? Colors.yellow
                                        : seria < 30
                                            ? Colors.orange
                                            : seria < 40
                                                ? Colors.red
                                                : Colors.purple,
                                fontWeight: FontWeight.bold)),
                        const Text(
                          " Dzień serii",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 255, 44, 16),
                            decorationColor: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 0,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                // child: Row(
                //   children: [
                //     Expanded(
                //       child: Divider(
                //         color: Color.fromARGB(255, 255, 72, 0),
                //         thickness: 2,
                //         indent: 20,
                //         endIndent: 20,
                //       ),
                //     ),
                //   ],
                // ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(48, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Postępy:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_right_sharp,
                          size: 30,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var progress in progressNotifier.progressData)
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.6,
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 21, 122, 114),
                                    Color.fromARGB(255, 167, 255, 251),
                                    Color.fromARGB(255, 21, 122, 114),
                                  ],
                                  stops: [0.0, 0.7, 1],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        progress.title,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        progress.category.icon,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        size: 30.0,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    progress.description,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  if (progress.category !=
                                      Category.postanowienie)
                                    Text(
                                      '${progress.date!.day}-${progress.date!.month}-${progress.date!.year}',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(179, 0, 0, 0),
                                      ),
                                    )
                                  else
                                    TimeCounter(date: progress.date)
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      iconSize: const WidgetStatePropertyAll(40),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primaryColor),
                      iconColor: const WidgetStatePropertyAll(Colors.black),
                      elevation: const WidgetStatePropertyAll(0)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Dodaj postęp'),
                          content: const ProgressForm(),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Anuluj'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Dodaj'),
                              onPressed: () {
                                final formState =
                                    ref.read(progressFormProvider);
                                if (formState.title.isNotEmpty &&
                                    formState.description.isNotEmpty &&
                                    formState.selectedCategory != null) {
                                  ref
                                      .read(progressProvider)
                                      .addProgress(Progress(
                                        title: formState.title,
                                        description: formState.description,
                                        category: formState.selectedCategory!,
                                        image: null,
                                        date: DateTime.now(),
                                      ));
                                  ref.read(progressProvider).saveProgress(ref);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Dodaj postęp',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              TextButton(onPressed: () {}, child: const Text('serialize')),
            ],
          ),
        )
      ],
    );
  }
}

class TimeCounter extends StatefulWidget {
  final DateTime? date;

  const TimeCounter({Key? key, required this.date}) : super(key: key);

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  late Timer _timer;
  String _timeString = 'Ładowanie...'; // Domyślna wartość

  @override
  void initState() {
    super.initState();
    if (widget.date != null) {
      _updateTime();
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        _updateTime();
      });
    }
  }

  @override
  void dispose() {
    if (widget.date != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _updateTime() {
    if (widget.date == null) {
      setState(() {
        _timeString = 'Brak daty';
        return;
      });
    }

    final difference = widget.date!.difference(DateTime.now());
    setState(() {
      _timeString = '${difference.inDays.abs()} dni '
          '${difference.inHours.abs() % 24} godzin '
          '${difference.inMinutes.abs() % 60} minut '
          '${difference.inSeconds.abs() % 60} sekund';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: const TextStyle(
          fontSize: 14.0,
          color: Color.fromARGB(179, 0, 0, 0),
          fontWeight: FontWeight.bold),
    );
  }
}

class ProgressForm extends ConsumerWidget {
  const ProgressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(progressFormProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: (value) => formState.updateTitle(value),
          decoration: const InputDecoration(hintText: "Tytuł"),
        ),
        TextField(
          onChanged: (value) => formState.updateDescription(value),
          decoration: const InputDecoration(hintText: "Opis"),
        ),
        DropdownButton<Category>(
          hint: Text(formState.chosenCategory),
          value: formState.selectedCategory,
          onChanged: (Category? newValue) {
            if (newValue != null) {
              formState.updateCategory(newValue);
            }
          },
          items: Category.values.map((Category category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Text(category.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}
