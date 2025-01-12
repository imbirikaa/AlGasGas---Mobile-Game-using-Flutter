import 'package:barra_modo3/models/player.dart';
import 'package:flutter/material.dart';

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
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              TextSpan(
                text: player.name,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onSecondary,
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
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  height: 1.5,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              )
            : Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'انت داخل الموضوع والموضوع هو',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    TextSpan(
                      text: "\n$word\n",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    TextSpan(
                      text: "المطلوب منك تعرف من القصقاص في الشوط هذا",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
