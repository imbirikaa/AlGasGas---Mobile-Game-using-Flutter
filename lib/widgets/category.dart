import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/screens/giving_word.dart';
import 'package:barra_modo3/theme/brutal_style.dart';
import 'package:barra_modo3/theme/page_transitions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barra_modo3/providers/category_provider.dart';

class CategoryItem extends ConsumerStatefulWidget {
  const CategoryItem({required this.category, super.key});
  final CategoryModel category;

  @override
  ConsumerState<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends ConsumerState<CategoryItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final offset = _pressed ? const Offset(2, 2) : const Offset(6, 6);
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        ref.read(categoryNotifier.notifier).setCategory(widget.category);
        Navigator.of(context).pushReplacement(
          brutalRoute(GivingWord()),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          _pressed ? 4 : 0,
          _pressed ? 4 : 0,
          0,
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(10),
        height: 250,
        width: 250,
        decoration: brutalBoxDecoration(
          color: widget.category.color,
          shadowOffset: offset,
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
      ),
    );
  }
}
