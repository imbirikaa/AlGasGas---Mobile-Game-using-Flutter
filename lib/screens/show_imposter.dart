import 'dart:math';
import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/screens/the_word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

import 'package:flutter/material.dart';

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
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TheWordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Show a confirmation dialog
          final shouldGoBack = await showDialog<bool>(
            context: context,
            builder: (context) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(
                    "تأكيد",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Ensures the column takes only necessary space
                    children: [
                      Text(
                        "هل أنت متأكد تبي ترجع ؟",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Add spacing between main content and sub-description
                      Text(
                        "لن يتم حفظ التغييرات لو رجعت.",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(false), // Stay on the page
                      child: Text(
                        "لا",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ExplanationScreen()),
                          (route) => false), // Go back
                      child: Text(
                        "نعم",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
          return shouldGoBack ?? false; // Return false if dialog is dismissed
        },
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' . . . القصقاص هو',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 80),
                  Text(
                    selectedItem!,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: (isRunning)
                          ? Theme.of(context).colorScheme.onSecondary
                          : Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
