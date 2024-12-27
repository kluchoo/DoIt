import 'package:do_it/models/progress_model.dart';
import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Progressdocumentations extends ConsumerStatefulWidget {
  const Progressdocumentations({super.key});

  @override
  ConsumerState<Progressdocumentations> createState() =>
      _ProgressdocumentationsState();
}

class _ProgressdocumentationsState
    extends ConsumerState<Progressdocumentations> {
  int seria = 0;
  @override
  void initState() {
    super.initState();
    _initializeSeria();
  }

  Future<void> _initializeSeria() async {
    seria = await ref.read(appUserProvider).dayStrikeUpdate();
    ref.read(progressProvider).updateProgress(progressData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ProgressNotifier progressNotifier = ref.watch(progressProvider);

    return Column(
      children: [
        Center(
          child: Column(
            children: [
              const Icon(
                Icons.local_fire_department_sharp,
                size: 200,
                color: Colors.red,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                                      : Colors.purple,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    " Dzień serii",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Twój postęp",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // for (var progress
                    //     in ref.watch(progressProvider).progressData)
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
              TextButton(
                  onPressed: () {
                    ref.read(progressProvider).addProgress(Progress(
                        title: 'tifsafasasftle',
                        description: 'dasdasda',
                        image: null,
                        icon: null));
                  },
                  child: Text('test')),
              TextButton(
                  onPressed: () {
                    debugPrint(progressNotifier.serializeProgress().toString());
                  },
                  child: Text('serialize')),
            ],
          ),
        )
      ],
    );
  }
}
