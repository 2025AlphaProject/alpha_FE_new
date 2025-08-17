// 카테고리 칩 뷰
import 'package:flutter/material.dart';

Widget buildTag(
  BuildContext context,
  String label, {
  bool selected = false,
  void Function(bool)? onSelected,
}) {
  final size = MediaQuery.of(context).size;

  return ChoiceChip(
    label: Text(label),
    labelStyle: TextStyle(
      fontSize: size.width * 0.032,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    selected: selected,
    onSelected: onSelected,
    showCheckmark: false,
    selectedColor: const Color(0xFFEF3F26),
    backgroundColor: const Color(0xAAEF3F26),
    shape: const StadiumBorder(),
  );
}
