import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/screens/show_imposter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/players.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Ensures the column takes only necessary space
                    children: [
                      Text(
                        "هل أنت متأكد تبي ترجع ؟",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Add spacing between main content and sub-description
                      Text(
                        "لن يتم حفظ التغييرات لو رجعت.",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
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
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ExplanationScreen()),
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
                  SizedBox(height: 30),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'اعطوا الجهاز لـ ',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                        ),
                        TextSpan(
                          text: players![i].name,
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'اختار الشخص اللي تحس انّه القصقاص',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
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
