import 'dart:math';

import 'package:barra_modo3/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

class GiveWord extends ConsumerStatefulWidget {
  const GiveWord({super.key});

  @override
  ConsumerState<GiveWord> createState() {
    return _GiveWordState();
  }
}

class _GiveWordState extends ConsumerState<GiveWord> {
  late List<Player> willAsked; // Mutable list to track players
  late List<Player> players; // Mutable list to track players
  late Player currentPlayer; // Current player
  Player? askedPlayer; // Current player
  int i = 0;

  @override
  void initState() {
    super.initState();
    players = ref.read(playersNotifier);
    willAsked = List.from(players);
    selectAndRemoveNextPlayer();
  }

  void selectAndRemoveNextPlayer() {
    setState(() {
      currentPlayer = players[i];

      final candidates =
          willAsked.where((player) => player != currentPlayer).toList();

      if (candidates.isNotEmpty) {
        final random = Random();
        askedPlayer = candidates[random.nextInt(candidates.length)];

        willAsked.remove(askedPlayer);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPlayer.name),
      ),
      body: Center(
        child: Column(
          children: [
            Text(currentPlayer.name),
            Text(askedPlayer!.name),
            SizedBox(height: 16),
            // Button to select and remove the next player
            ElevatedButton(
              onPressed: willAsked.isNotEmpty
                  ? () {
                      i++;
                      selectAndRemoveNextPlayer();
                    }
                  : null,
              child: Text(
                  willAsked.isNotEmpty ? "Next Player" : "No More Players"),
            ),
          ],
        ),
      ),
    );
  }
}
