import 'package:barra_modo3/models/player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Second extends StatelessWidget {
  const Second({required this.player, required this.word, super.key});

  final Player player;
  final String word;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'اعطوا الجهاز لـ ',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
              TextSpan(
                text: player.name,
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        (player.isImposter)
            ? Text(
                'انت القصقاص في الشوط هذا . حاول تعرف شن الموضوع اللي يتكلموا عليه من الهدرزة متاعهم وماتخليهمش يشكّوا فيك',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  height: 1.5,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              )
            : Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'انت داخل الموضوع والموضوع هو',
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        height: 1.5,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ),
                    TextSpan(
                      text: "\n$word\n",
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        height: 1.5,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ),
                    TextSpan(
                      text: "المطلوب منك تعرف من القصقاص في الشوط هذا",
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        height: 1.5,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
