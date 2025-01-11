import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/screens/giving_word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/category_provider.dart';

class CategoryItem extends ConsumerStatefulWidget {
  const CategoryItem({required this.category, super.key});
  final CategoryModel category;

  @override
  ConsumerState<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends ConsumerState<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.onSecondary,
      onTap: () {
        ref.read(categoryNotifier.notifier).setCategory(widget.category);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => GivingWord(),
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
          color: widget.category.color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.category.iconPath,
                height: 160,
                width: 160,
              ),
              Text(
                widget.category.title,
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
