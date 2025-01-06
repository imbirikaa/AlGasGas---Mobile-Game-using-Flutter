import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/screens/giving_word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.category, super.key});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.onSecondary,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GivingWord(
              category: category,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(10),
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: category.color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                category.iconPath,
                height: 160,
                width: 160,
              ),
              Text(
                category.title,
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
