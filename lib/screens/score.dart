import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/add_player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/screens/giving_word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

class ScoreSreen extends ConsumerStatefulWidget {
  const ScoreSreen({super.key});

  @override
  ConsumerState<ScoreSreen> createState() => _ScoreSreenState();
}

class _ScoreSreenState extends ConsumerState<ScoreSreen> {
  late List<Player> players;

  @override
  void initState() {
    players = ref.read(playersNotifier);
    super.initState();
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
                Text(
                  'النقـــاط',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                SizedBox(height: 80),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      itemCount: players.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    players[index].points.toString(),
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '------------------',
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    players[index].name,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
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
                      ElevatedButton.icon(
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          'تغيير اللاعبين',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => AddPlayerScreen()),
                              (route) => false);
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          'كلمة من نفس الموضوع',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        icon: Icon(Icons.flag),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => GivingWord()),
                              (route) => false);
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          'غيّر الموضوع',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen()),
                              (route) => false);
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
    );
  }
}
