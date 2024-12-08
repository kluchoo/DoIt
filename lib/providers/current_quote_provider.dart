import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentQuoteNotifier extends StateNotifier<CurrentQuoteState> {
  CurrentQuoteNotifier() : super(CurrentQuoteState());

  void increment(int value) {
    state = state.copyWith(skipped: state.skipped + value);
  }

  void restart() {
    state = CurrentQuoteState();
  }
}

class CurrentQuoteState {
  final int skipped;
  final int displayed;

  CurrentQuoteState({this.skipped = 0, this.displayed = 2});

  CurrentQuoteState copyWith({int? skipped, int? displayed}) {
    return CurrentQuoteState(
      skipped: skipped ?? this.skipped,
      displayed: displayed ?? this.displayed,
    );
  }
}

// ...provider definition...
