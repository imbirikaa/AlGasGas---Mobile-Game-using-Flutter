import 'dart:math';

import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/add_player.dart';
import 'package:barra_modo3/screens/asking.dart';
import 'package:barra_modo3/widgets/first.dart';
import 'package:barra_modo3/widgets/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';
import 'package:google_fonts/google_fonts.dart';

class GivingWord extends ConsumerStatefulWidget {
  const GivingWord({required this.category, super.key});

  final CategoryModel category;

  @override
  ConsumerState<GivingWord> createState() {
    return _GivingWordState();
  }
}

class _GivingWordState extends ConsumerState<GivingWord> {
  late final String word;
  late final List<Player> players;
  final random = Random();
  String page = 'first';
  int i = 0;

  void selectImposter() {
    for (Player p in players) {
      p.isImposter = false;
    }

    players[random.nextInt(players.length)].isImposter = true;
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
    word = widget.category.getRandomItem();
    players = ref.read(playersNotifier);
    selectImposter();
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
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                content: Text(
                  "هل أنت متأكد تبي تطلع ؟",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false), // Stay on the page
                    child: Text(
                      "لا",
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
                  TextButton(
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => AddPlayerScreen()),
                        (route) => false), // Go back
                    child: Text(
                      "نعم",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.redAccent,
                                ),
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (page == 'first') {
                        page = 'second';
                      } else if (page == 'second' && i < players.length - 1) {
                        page = 'first';
                        i++;
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => AskingScreen(),
                          ),
                        );
                      }
                    });
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
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
