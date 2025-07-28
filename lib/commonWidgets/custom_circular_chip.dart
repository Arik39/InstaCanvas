import 'package:flutter/material.dart';

import '../common_functions.dart';
import 'text_widget.dart';

class CustomCircularTab extends StatelessWidget {
  final String title;
  final String id;
  final String selectedId;
  final double dW;
  final bool applyRightMargin;
  const CustomCircularTab({
    super.key,
    required this.title,
    required this.id,
    required this.selectedId,
    required this.dW,
    this.applyRightMargin = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedId == id;
    Color primaryColor = getThemeColor();
    return Container(
      margin: EdgeInsets.only(right: applyRightMargin ? dW * 0.02 : 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? primaryColor : const Color(0xffBFC0C8),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextWidget(
        title: title,
        fontSize: isSelected ? 17 : 16,
        color: isSelected ? Colors.white : const Color(0xffBFC0C8),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
