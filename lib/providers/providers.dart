import 'package:do_it/models/form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressFormProvider =
    ChangeNotifierProvider((ref) => ProgressFormState());
