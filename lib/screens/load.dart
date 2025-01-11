import 'package:barra_modo3/screens/explanation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.primary.withAlpha(200),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'لعبة من القصقاص ؟',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/images/spy.png',
              width: 200,
              color: const Color.fromARGB(240, 255, 255, 255),
            ),
            SizedBox(height: 30),
            SizedBox(height: 30),
            ElevatedButton.icon(
              iconAlignment: IconAlignment.end,
              label: Text(
                'ابدأ اللعبة',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              icon: Icon(Icons.start),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => ExplanationScreen()),
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
