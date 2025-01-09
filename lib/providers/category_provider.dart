import 'package:barra_modo3/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<CategoryModel> {
  CategoryNotifier()
      : super(CategoryModel(
            title: 'Default', items: [], color: Colors.red, iconPath: ""));

  void setCategory(CategoryModel category) {
    state = category;
  }
  
}

final categoryNotifier =
    StateNotifierProvider<CategoryNotifier, CategoryModel>((ref) {
  return CategoryNotifier();
});
