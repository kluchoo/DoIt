import 'package:do_it/models/progress_model.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif/gif.dart';

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
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 255, 72, 0),
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
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
                          "Twój postęp",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_right_sharp,
                          size: 30,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var progress in progressNotifier.progressData)
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    progress.title,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    progress.description,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white70,
                                    ),
                                  ),
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
                  onPressed: () {
                    ref.read(progressProvider).addProgress(Progress(
                        title: 'tifsafasasftle',
                        description: 'dasdasda',
                        image: null,
                        icon: null));
                  },
                  child: const Text('test')),
              TextButton(
                  onPressed: () {
                    debugPrint(progressNotifier.serializeProgress().toString());
                  },
                  child: const Text('serialize')),
            ],
          ),
        )
      ],
    );
  }
}
