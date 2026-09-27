import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/screens/show_imposter.dart';
import 'package:barra_modo3/widgets/exit_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

class WhoIsScreen extends ConsumerStatefulWidget {
  const WhoIsScreen({super.key});

  @override
  ConsumerState<WhoIsScreen> createState() => _WhoIsScreenState();
}

class _WhoIsScreenState extends ConsumerState<WhoIsScreen> {
  late List<Player>? players;
  late Player? imposterPlayer;
  int i = 0;

  @override
  void initState() {
    super.initState();
    players = ref.read(playersNotifier);
    imposterPlayer = ref.read(playersNotifier.notifier).findImposter();
    i = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExitConfirmationScope(
        onConfirm: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ExplanationScreen()),
            (route) => false),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
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
                  SizedBox(height: 80),
                  Text(
                    'مرحلة التصويت',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'اعطوا الجهاز لـ ',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        TextSpan(
                          text: players![i].name,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'اختار الشخص اللي تحس انّه القصقاص',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: players!
                          .where((p) => p != players![i])
                          .toList()
                          .length,
                      itemBuilder: (ctx, index) => ElevatedButton(
                        onPressed: () {
                          if (players!
                                  .where((p) => p != players![i])
                                  .toList()[index] ==
                              imposterPlayer) {
                            players![i].points += 10;
                          }
                          if (i >= players!.length - 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ShowImposterScreen(),
                              ),
                            );
                          } else {
                            setState(() {
                              i++;
                            });
                          }
                        },
                        child: Text(
                          players!
                              .where((p) => p != players![i])
                              .toList()[index]
                              .name,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
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
