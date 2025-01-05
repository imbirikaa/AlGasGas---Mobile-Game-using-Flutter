import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/models/player.dart';

class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier() : super([]);

  void addPlayer(String name) {
    final player = Player(name);

    state = [player, ...state];
  }

  void removePlayer(Player player) {
    state = [...state]..remove(player);
  }
}

final playersNotifier =
    StateNotifierProvider<PlayersNotifier, List<Player>>((ref) {
  return PlayersNotifier();
});
