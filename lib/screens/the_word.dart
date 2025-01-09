import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/word_provider.dart';
import 'package:barra_modo3/providers/category_provider.dart';
import 'package:barra_modo3/providers/players.dart';
import 'package:google_fonts/google_fonts.dart';

class TheWordScreen extends ConsumerStatefulWidget {
  const TheWordScreen({super.key});

  @override
  ConsumerState<TheWordScreen> createState() => _TheWordScreenState();
}

class _TheWordScreenState extends ConsumerState<TheWordScreen> {
  late String theWord;
  late CategoryModel category;
  late List<String> answers;
  late Player imposter;
  bool isSelected = false;
  int? selectedIndex;
  bool isCorrect = false;

  @override
  void initState() {
    theWord = ref.read(wordNotifier);
    category = ref.read(categoryNotifier);
    answers = CategoryModel.getShuffledAnswers(category, theWord);
    imposter = ref.read(playersNotifier.notifier).findImposter();
    super.initState();
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
              children: [
                SizedBox(height: 80),
                Text(
                  'مرحلة التصويت',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        text: imposter.name,
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
                  'اختار الكلمة اللي تحس ان الموضوع عليها',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
                SizedBox(height: 50),
                Expanded(
                  child: ListView.builder(
                    itemCount: answers.length,
                    itemBuilder: (ctx, index) => ElevatedButton(
                      onPressed: (isSelected)
                          ? null
                          : () async {
                              setState(() {
                                selectedIndex = index;
                                isSelected = true;
                                isCorrect = answers[index] == theWord;
                                if (isCorrect) {
                                  imposter.points += 10;
                                }
                              });
                              await Future.delayed(Duration(seconds: 3));
                              if (mounted) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ScoreSreen()));
                              }
                            },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            (selectedIndex == index)
                                ? ((answers[index] == theWord)
                                    ? Colors.green
                                    : Colors.red)
                                : (isSelected && answers[index] == theWord)
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                      ),
                      child: Text(
                        answers[index],
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
    );
  }
}
