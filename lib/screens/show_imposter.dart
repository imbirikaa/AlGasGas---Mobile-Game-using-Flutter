import 'dart:math';
import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/the_word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowImposterScreen extends ConsumerStatefulWidget {
  const ShowImposterScreen({super.key});

  @override
  ConsumerState<ShowImposterScreen> createState() => _ShowImposterScreenState();
}

class _ShowImposterScreenState extends ConsumerState<ShowImposterScreen> {
  String? selectedItem;
  bool isRunning = false;
  late String imposterName;
  late List<Player> players;

  @override
  void initState() {
    players = ref.read(playersNotifier);
    imposterName = ref.read(playersNotifier.notifier).findImposter().name;
    startRandomSelection();
    super.initState();
  }

  void startRandomSelection() async {
    setState(() {
      isRunning = true;
      selectedItem = null; // Reset the selected item
    });

    Random random = Random();
    int iterations = 30; // Number of times to show random items
    for (int i = 0; i < iterations; i++) {
      setState(() {
        selectedItem = players[random.nextInt(players.length)].name;
      });
      await Future.delayed(Duration(milliseconds: 100));
    }

    // Stop on a final item
    setState(() {
      selectedItem = imposterName;
      isRunning = false;
    });

    // Pause for 5 seconds
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TheWordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' . . . القصقاص هو',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                SizedBox(height: 80),
                Text(
                  selectedItem!,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: (isRunning)
                              ? Theme.of(context).colorScheme.onSecondary
                              : Colors.redAccent,
                        ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
