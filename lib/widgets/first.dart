import 'package:barra_modo3/models/player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Text(
          'أضغط التالي بيش تعرف هل انت القصقاص ولا لا ؟ وماتخليش حد يشوف الشاشة معـــــــــاك',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            fontSize: 20,
            height: 1.5,
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ),
      ],
    );
  }
}
