import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordNotifier extends StateNotifier<String> {
  WordNotifier() : super("");

  void setWord(String newWord) {
    state = newWord;
  }
}

final wordNotifier = StateNotifierProvider<WordNotifier, String>((ref) {
  return WordNotifier();
});
