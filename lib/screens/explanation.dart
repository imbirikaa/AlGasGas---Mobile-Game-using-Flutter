import 'package:barra_modo3/screens/add_player.dart';
import 'package:barra_modo3/screens/load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

class ExplanationScreen extends ConsumerStatefulWidget {
  const ExplanationScreen({super.key});

  @override
  ConsumerState<ExplanationScreen> createState() => _ExplanationScreenState();
}

class _ExplanationScreenState extends ConsumerState<ExplanationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoadScreen()),
            (route) => false,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(200),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "🎮 لعبة من القصقاص",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'لعبة ضحك وتركيز مع صحابك',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    ':الفكرة',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'كل اللاعبين يعرفوا الكلمة إلا شخص واحد بـ يكون',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'القصقاص',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    ':القواعد',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تسألوا بعض أسئلة عن الكلمة، والشخص "القصقاص" يحاول يجاوب بشكل طبيعي بدون ما ينكشف، بينما باقي اللاعبين يحاولوا يكتشفوا من هو الشخص اللي ما يعرفش الكلمة. في النهاية، تطلع قائمة للشخص "القصقاص"، ويكون عليه يحاول يخمن الكلمة الصح',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      "! جاهزين",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    icon: Icon(Icons.start),
                    onPressed: () {
                      ref.read(playersNotifier.notifier).cleanPlayers();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (ctx) => AddPlayerScreen(),
                        ),
                        (route) => false,
                      );
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
