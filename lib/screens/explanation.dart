import 'package:barra_modo3/screens/add_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "🎮 لعبة برّا الموضوع",
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'لعبة ضحك وتركيز مع صحابك',
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                ':الفكرة',
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'كل اللاعبين يعرفوا الكلمة إلا شخص واحد بـ يكون',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'القصقاص',
                style: GoogleFonts.rubik(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.redAccent,
                      ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                ':القواعد',
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'تسألوا بعض أسئلة عن الكلمة، والشخص "القصقاص" يحاول يجاوب بشكل طبيعي بدون ما ينكشف، بينما باقي اللاعبين يحاولوا يكتشفوا من هو الشخص اللي ما يعرفش الكلمة. في النهاية، تطلع قائمة للشخص "القصقاص"، ويكون عليه يحاول يخمن الكلمة الصح',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  height: 1.5,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                label: Text(
                  "! جاهزين",
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddPlayerScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
