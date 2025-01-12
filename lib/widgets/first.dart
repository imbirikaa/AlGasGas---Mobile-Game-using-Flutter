import 'package:barra_modo3/models/player.dart';
import 'package:flutter/material.dart';

class First extends StatelessWidget {
  const First({required this.player, super.key});

  final Player player;

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
        Text(
          'أضغط التالي بيش تعرف هل انت القصقاص ولا لا ؟ وماتخليش حد يشوف الشاشة معـــــــــاك',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 20,
            height: 1.5,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
