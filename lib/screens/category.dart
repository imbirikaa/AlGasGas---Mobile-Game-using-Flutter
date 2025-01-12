import 'package:barra_modo3/models/category.dart';
import 'package:barra_modo3/screens/add_player.dart';
import 'package:barra_modo3/widgets/category.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryModel.getCategories();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AddPlayerScreen()),
            (route) => false,
          );
          return false; // Prevent default back button behavior
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
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
                  Text(
                    'أختاروا موضوع',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) => CategoryItem(
                        category: categories[index],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
