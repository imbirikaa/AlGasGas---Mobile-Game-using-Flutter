import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/category.dart';
import 'package:barra_modo3/screens/explanation.dart';
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
                                leading:
                                    Icon(Icons.person, color: Colors.green),
                                title: Text(
                                  players[index].name,
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
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
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
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        icon: Icon(Icons.flag),
                        onPressed: (players.length < 4)
                            ? null
                            : () {
                                ref
                                    .read(playersNotifier.notifier)
                                    .cleanPoints();

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
      ),
    );
  }
}
