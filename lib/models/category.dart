import 'dart:math';

import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel({
    required this.title,
    required this.items,
    required this.color,
    required this.iconPath,
  });
  final String title;
  final List<String> items;
  final Color color;
  final String iconPath;

  static List<CategoryModel> getCategories() {
    final List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        title: 'حيوانات',
        items: [
          "أسد",
          "نمر",
          "فيل",
          "زرافة",
          "حمار وحشي",
          "كنغر",
          "باندا",
          "فهد",
          "غوريلا",
          "بطريق",
          "دب قطبي",
          "ثعلب",
          "غزال",
          "ذئب",
          "كوالا",
          "جمل",
          "فرس النهر",
          "وحيد القرن",
          "تمساح",
          "دلفين",
          "حوت",
          "قرش",
          "أخطبوط",
          "سلطعون",
          "ثعبان",
          "ببغاء",
          "بومة",
          "نسر",
          "عصفور",
          "طاووس",
          "أرنب",
          "قطة",
          "كلب",
          "حصان",
          "خروف",
          "ماعز",
          "دب",
          "ضفدع",
          "سحلية",
          "فراشة",
          "نملة",
          "نحلة",
          "عنكبوت",
          "خفاش",
          "ديك رومي",
          "بطة",
          "بجعة",
          "فلامينغو",
          "فقمة",
          "ثعلب الماء"
        ],
        color: Colors.blue,
        iconPath: 'assets/icons/animals.png',
      ),
    );

    categories.add(
      CategoryModel(
        title: 'فواكه وخضروات',
        items: [
          "تفاح",
          "موز",
          "برتقال",
          "عنب",
          "أناناس",
          "مانجو",
          "فراولة",
          "توت أزرق",
          "توت",
          "بطيخ",
          "خوخ",
          "برقوق",
          "كرز",
          "كمثرى",
          "كيوي",
          "ليمون",
          "لايم",
          "جوز الهند",
          "بابايا",
          "جوافة",
          "أفوكادو",
          "طماطم",
          "بطاطس",
          "جزر",
          "خيار",
          "بصل",
          "ثوم",
          "زنجبيل",
          "سبانخ",
          "خس",
          "بروكلي",
          "قرنبيط",
          "ملفوف",
          "يقطين",
          "كوسة",
          "بطاطا حلوة",
          "فجل",
          "شمندر",
          "بازلاء",
          "فاصوليا",
          "ذرة",
          "كرفس",
          "هليون",
          "خرشوف",
          "فطر",
          "فلفل حلو",
          "فلفل حار",
          "باذنجان",
          "بامية",
          "لفت",
          "جزر أبيض"
        ],
        color: Colors.orange,
        iconPath: 'assets/icons/fruits.png',
      ),
    );
    categories.add(
      CategoryModel(
        title: 'أكلات شعبية',
        items: [
          "بازّين",
          "عصبان",
          "كُسكُسي",
          "مبطن",
          "رشدة",
          "شربة",
          "طبيخة",
          "ملوخية",
          "مقروض",
          "بوريك",
          "طاجين بطاطا",
          "فتات",
          "بازين بالحوت",
          "عصيدة"
        ],
        color: Colors.redAccent,
        iconPath: 'assets/icons/food.png',
      ),
    );
    categories.add(
      CategoryModel(
        title: 'ملابس',
        items: [
          "تيشيرت",
          "قميص",
          "شخشير",
          "سروال",
          "شورت",
          "قرواطة",
          "قفطان",
          "جاكيت",
          "جابوطي",
          "توب",
          "ساعة",
          "بوتيل",
          "شبشب",
          "نظارة شمسية",
          "سبتة"
        ],
        color: Colors.indigo,
        iconPath: 'assets/icons/clothes.png',
      ),
    );
    return categories;
  }

  String getRandomItem() {
    final int index = Random().nextInt(items.length);
    return items[index];
  }

  static List<String> getShuffledAnswers(
      CategoryModel category, String answer) {
    final random = Random();

    final items = category.items;

    final filteredItems = items.where((item) => item != answer).toList();

    final randomItems = List<String>.generate(
      7,
      (_) {
        final index = random.nextInt(filteredItems.length);
        return filteredItems.removeAt(index);
      },
    );

    randomItems.add(answer);

    randomItems.shuffle(random);

    return randomItems;
  }
}
