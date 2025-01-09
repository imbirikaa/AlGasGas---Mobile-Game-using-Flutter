import 'dart:math';

import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/screens/who_is.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool secondRound = false;
  bool anyAsking = false;
  int i = 0;

  @override
  void initState() {
    super.initState();

    i = 0;
    players = ref.read(playersNotifier);
    willAsked = List.from(players);
    selectAndRemoveNextPlayer();
  }

  void selectAndRemoveNextPlayer() {
    setState(() {
      final candidates =
          willAsked.where((player) => player != players[i]).toList();

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
      body: Container(
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
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                SizedBox(height: 30),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: players[i].name,
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          height: 1.5,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ),
                      TextSpan(
                        text: ' اسأل ',
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          height: 1.5,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ),
                      TextSpan(
                        text: (secondRound) ? 'أي حد' : askedPlayer!.name,
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          height: 1.5,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ),
                      TextSpan(
                        text:
                            ' سؤال ليه علاقة بالموضوع ! اسأل سؤال مليح ماتخليش القصقاص يعرف الموضوع',
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          height: 1.5,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (willAsked.isNotEmpty) {
                      i++;

                      selectAndRemoveNextPlayer();
                    } else if (willAsked.isEmpty &&
                        (i < players.length - 1 || !secondRound)) {
                      if (!secondRound) {
                        setState(() {
                          i = 0;
                          secondRound = true;
                        });
                      } else {
                        setState(() {
                          if (i < players.length - 1) {
                            i++;
                          }
                        });
                      }
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WhoIsScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'التالــــي',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
