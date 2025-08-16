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
    label: Text(
      label,
      style: TextStyle(
        fontSize: size.width * 0.032,
        fontWeight: FontWeight.w500,
        color:
            selected ? Colors.white : Theme.of(context).colorScheme.onSurface,
      ),
    ),
    selected: selected,
    onSelected: onSelected,
    selectedColor: Theme.of(context).colorScheme.primary,
    backgroundColor: Colors.grey.shade200,
    shape: const StadiumBorder(),
  );
}
