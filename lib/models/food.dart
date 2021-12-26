import 'package:flutter/gestures.dart';

class Food {
  String? thName;
  String? enName;
  String? foodvalue;
  int? price;

  Food(this.enName,this.thName,this.foodvalue,this.price);

  static List<Food> getFood() {
    return[
      Food('Pizza', 'พิชซ่า','pizza', 59),
      Food('steak', 'สเต็ก','steak', 239),
      Food('salad', 'สลัด','salad', 79),
      Food('Shabu', 'ชาบู','shabu', 599),
    ];
  }

}