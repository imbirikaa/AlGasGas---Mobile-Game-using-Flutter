import 'dart:math';

final categories = {
  "animals": [
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
  "fruitsAndVegetables": [
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
  "clothes": [
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
  "libyanFood": [
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
  ]
};

String getRandomItem(String category) {
  final random = Random();

  final items = categories[category]!;

  return items[random.nextInt(items.length)];
}

List<String> getShuffledAnswers(String category, String answer) {
  final random = Random();

  final items = categories[category]!;

  final filteredItems = items.where((item) => item != answer).toList();

  final randomItems = List<String>.generate(
    8,
    (_) {
      final index = random.nextInt(filteredItems.length);
      return filteredItems.removeAt(index);
    },
  );

  randomItems.add(answer);

  randomItems.shuffle(random);

  return randomItems;
}
