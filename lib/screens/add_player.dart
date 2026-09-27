import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/theme/brutal_style.dart';
import 'package:barra_modo3/theme/page_transitions.dart';
import 'package:barra_modo3/widgets/exit_confirmation_dialog.dart';
import 'package:flutter/material.dart';

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
      body: ExitConfirmationScope(
        onConfirm: () => Navigator.of(context).pushAndRemoveUntil(
            brutalRoute(ExplanationScreen()), (route) => false),
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
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      'اضافة اللاعبين',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'اقل شيء 4 لاعبين',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200),
                      ),
                      decoration: InputDecoration(
                        hintText: 'اكتب اسم اللاعب',
                        hintStyle: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(150),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Dismissible(
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
                                decoration: brutalBoxDecoration(
                                  color: Colors.redAccent,
                                  shadowOffset: const Offset(4, 4),
                                ),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: brutalBoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  shadowOffset: const Offset(4, 4),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                    leading:
                                        Icon(Icons.person, color: Colors.green),
                                    title: Text(
                                      players[index].name,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
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
                      BrutalButton(
                        label: "أضف لاعب",
                        icon: Icons.person,
                        onPressed: _addPlayer,
                      ),
                      SizedBox(width: 24),
                      BrutalButton(
                        label: "! جاهزين",
                        icon: Icons.flag,
                        onPressed: (players.length < 4)
                            ? null
                            : () {
                                ref
                                    .read(playersNotifier.notifier)
                                    .cleanPoints();

                                Navigator.of(context).push(
                                  brutalRoute(CategoryScreen()),
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
      ),
    );
  }
}
