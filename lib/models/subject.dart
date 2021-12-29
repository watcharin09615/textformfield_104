import 'package:flutter/gestures.dart';

class Subject {
  String? subId;
  String? subName;
  int? credit;
  bool? checked = false;

  Subject(this.subId,this.subName,this.credit,this.checked);

  static List<Subject> getSubject() {
    return[
      Subject('00001', 'Mobile App',3, false),
      Subject('00002', 'Chat Bot',3, false),
      Subject('00003', 'Decision Support System',3, false),
      Subject('00004', 'Arts',3, false),
      Subject('00005', 'History',1, false),
    ];
  }

}