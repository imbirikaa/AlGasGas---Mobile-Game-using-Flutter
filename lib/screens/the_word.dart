import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/models/player.dart';
import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/screens/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/word_provider.dart';
import 'package:barra_modo3/providers/category_provider.dart';
import 'package:barra_modo3/providers/players.dart';

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
                children: [
                  SizedBox(height: 80),
                  Text(
                    'اختيار الكلمة',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'اعطوا الجهاز لـ ',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        TextSpan(
                          text: imposter.name,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'اختار الكلمة اللي تحس ان الموضوع عليها',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height:30),
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
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
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
