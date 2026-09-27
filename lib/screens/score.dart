import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/add_player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/screens/giving_word.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';
import 'package:barra_modo3/widgets/exit_confirmation_dialog.dart';
import 'package:barra_modo3/theme/brutal_style.dart';
import 'package:barra_modo3/theme/page_transitions.dart';

class ScoreSreen extends ConsumerStatefulWidget {
  const ScoreSreen({super.key});

  @override
  ConsumerState<ScoreSreen> createState() => _ScoreSreenState();
}

class _ScoreSreenState extends ConsumerState<ScoreSreen> {
  late List<Player> players;
  late List<Player> orderdPlayers;

  @override
  void initState() {
    players = ref.read(playersNotifier);
    orderdPlayers = List.from(players);
    orderdPlayers.sort((a, b) => b.points.compareTo(a.points));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExitConfirmationScope(
        onConfirm: () => Navigator.of(context).pushAndRemoveUntil(
            brutalRoute(ExplanationScreen()), (route) => false),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                  Text(
                    'النقـــاط',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 80),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        itemCount: players.length,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      orderdPlayers[index].points.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '-----------------',
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (index == 0 &&
                                            orderdPlayers[index].points > 0)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6),
                                            child: Icon(Icons.emoji_events,
                                                color: Colors.amber,
                                                size: 22),
                                          ),
                                        Text(
                                          orderdPlayers[index].name,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BrutalButton(
                          label: 'تغيير اللاعبين',
                          icon: Icons.person,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                brutalRoute(AddPlayerScreen()));
                          },
                        ),
                        SizedBox(height: 10),
                        BrutalButton(
                          label: 'كلمة من نفس الموضوع',
                          icon: Icons.flag,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(brutalRoute(GivingWord()));
                          },
                        ),
                        SizedBox(height: 10),
                        BrutalButton(
                          label: 'غيّر الموضوع',
                          icon: Icons.edit,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(brutalRoute(CategoryScreen()));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
