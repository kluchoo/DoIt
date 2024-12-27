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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    " Dzień serii",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    ref.read(appUserProvider).dayStrikeUpdate();
                  },
                  child: Text('test'))
            ],
          ),
        )
      ],
    );
  }
}
