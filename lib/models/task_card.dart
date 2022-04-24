import 'dart:ui';

import 'package:flutter_svg/svg.dart';


class TaskCard {
  String? title;
  int amount = 0;
  Color? bg_color;
  String icon;

  TaskCard({this.title, this.bg_color,required this.icon});
}
