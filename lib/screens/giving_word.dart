import 'dart:math';
import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/providers/category_provider.dart';
import 'package:barra_modo3/providers/word_provider.dart';
import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/asking.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/widgets/first.dart';
import 'package:barra_modo3/widgets/second.dart';
import 'package:barra_modo3/widgets/exit_confirmation_dialog.dart';
import 'package:barra_modo3/theme/brutal_style.dart';
import 'package:barra_modo3/theme/page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

class GivingWord extends ConsumerStatefulWidget {
  const GivingWord({super.key});

  @override
  ConsumerState<GivingWord> createState() {
    return _GivingWordState();
  }
}

class _GivingWordState extends ConsumerState<GivingWord> {
  late CategoryModel category;

  late final String word;
  late final List<Player> players;
  final random = Random.secure();
  String page = 'first';
  int i = 0;

  void selectImposter() {
    List<Player> randomPlayers = List.from(players);
    randomPlayers.shuffle();
    for (Player p in randomPlayers) {
      p.isImposter = false;
    }

    randomPlayers[random.nextInt(randomPlayers.length)].isImposter = true;
  }

  Widget firstPage() {
    return First(player: players[i]);
  }

  Widget secondPage() {
    return Second(
      player: players[i],
      word: word,
    );
  }

  @override
  void initState() {
    super.initState();
    category = ref.read(categoryNotifier);
    word = category.getRandomItem();

    players = ref.read(playersNotifier);
    selectImposter();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wordNotifier.notifier).setWord(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ExitConfirmationScope(
      onConfirm: () => Navigator.of(context).pushAndRemoveUntil(
          brutalRoute(CategoryScreen()), (route) => false),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(200),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                (page == 'first') ? firstPage() : secondPage(),
                Spacer(),
                BrutalButton(
                  label: 'التالــــي',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    setState(() {
                      if (page == 'first') {
                        page = 'second';
                      } else if (page == 'second' && i < players.length - 1) {
                        page = 'first';
                        i++;
                      } else {
                        Navigator.of(context).pushReplacement(
                          brutalRoute(AskingScreen()),
                        );
                      }
                    });
                  },
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
