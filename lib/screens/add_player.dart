import 'dart:math';

import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';

class AddPlayerScreen extends ConsumerStatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  ConsumerState<AddPlayerScreen> createState() {
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends ConsumerState<AddPlayerScreen> {
  final _nameController = TextEditingController();

  void _addPlayer() {
    if (_nameController.text.trim().isNotEmpty) {
      ref.read(playersNotifier.notifier).addPlayer(_nameController.text);
      _nameController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Player> players = ref.watch(playersNotifier);
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
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    'اضافة اللاعبين',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(200),
                              ),
                    ),
                    decoration: InputDecoration(
                      hintText: 'اكتب اسم اللاعب',
                      hintStyle: GoogleFonts.rubik(
                        fontSize: 16,
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(200),
                                ),
                      ),
                      suffixIcon: Icon(Icons.person, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: ValueKey(players[index].id),
                          onDismissed: (direction) {
                            ref
                                .read(playersNotifier.notifier)
                                .removePlayer(players[index]);
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              leading: Icon(Icons.person, color: Colors.green),
                              title: Text(
                                players[index].name,
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        "أضف لاعب",
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
                      onPressed: _addPlayer,
                    ),
                    SizedBox(width: 24),
                    ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        "! جاهزين",
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
                      onPressed: (players.length < 4)
                          ? () {}
                          : () {
                              final random = Random();

                              players[random.nextInt(players.length)]
                                  .isImposter = true;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => CategoryScreen(),
                                ),
                              );
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
