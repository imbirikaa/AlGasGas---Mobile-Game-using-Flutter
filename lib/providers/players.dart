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

  void cleanPoints() {
    for (Player p in state) {
      p.points = 0;
    }
  }

  void cleanImposter() {
    for (Player p in state) {
      p.isImposter = false;
    }
  }

  Player findImposter() {
    return state.firstWhere((player) => player.isImposter == true);
  }
}

final playersNotifier =
    StateNotifierProvider<PlayersNotifier, List<Player>>((ref) {
  return PlayersNotifier();
});
