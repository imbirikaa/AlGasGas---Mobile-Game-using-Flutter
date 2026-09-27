import 'dart:math';

import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/screens/who_is.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';
import 'package:barra_modo3/widgets/exit_confirmation_dialog.dart';
import 'package:barra_modo3/theme/brutal_style.dart';
import 'package:barra_modo3/theme/page_transitions.dart';

class AskingScreen extends ConsumerStatefulWidget {
  const AskingScreen({super.key});

  @override
  ConsumerState<AskingScreen> createState() {
    return _AskingScreenState();
  }
}

class _AskingScreenState extends ConsumerState<AskingScreen> {
  late List<Player> willAsked; // Mutable list to track players
  late List<Player> players; // Mutable list to track players

  Player? askedPlayer; // Current player
  Player? askingPlayer; // Current player
  bool secondRound = false;
  bool anyAsking = false;
  int i = 0;
  bool fin = false;

  @override
  void initState() {
    super.initState();

    i = 0;
    players = ref.read(playersNotifier);
    willAsked = List.from(players);
    willAsked.shuffle(Random());
    while (_hasSelfAsking()) {
      willAsked.shuffle(Random());
    }
    asking();
  }

  void asking() {
    setState(() {
      askedPlayer = willAsked[i];
    });
  }

  bool _hasSelfAsking() {
    for (int i = 0; i < players.length; i++) {
      if (players[i] == willAsked[i]) {
        return true;
      }
    }
    return false;
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
                  SizedBox(height: 150),
                  Text(
                    'مرحلة الأسئلة',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: players[i].name,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 20,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        TextSpan(
                          text: ' اسأل ',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 20,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        TextSpan(
                          text: (secondRound) ? 'أي حد' : askedPlayer!.name,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 20,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' سؤال ليه علاقة بالموضوع ! اسأل سؤال مليح ماتخليش القصقاص يعرف الموضوع',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 20,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  BrutalButton(
                    label: 'التالــــي',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      if (i < players.length - 1) {
                        if (!secondRound) {
                          i++;
                          asking();
                        } else {
                          setState(() {
                            i++;
                          });
                        }
                      } else if (i >= players.length - 1 && !secondRound) {
                        setState(() {
                          i = 0;
                          secondRound = true;
                        });
                      } else {
                        Navigator.of(context).pushReplacement(
                          brutalRoute(WhoIsScreen()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
