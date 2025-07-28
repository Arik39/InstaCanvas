import 'package:flutter/material.dart';

import '../common_functions.dart';
import 'text_widget.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final String id;
  final String selectedId;
  final double dW;
  final bool applyRightMargin;
  const CustomTab({
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
    return Container(
      margin: EdgeInsets.only(right: applyRightMargin ? dW * 0.05 : 0),
      padding: EdgeInsets.only(bottom: dW * 0.015),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isSelected ? getThemeColor() : Colors.white,
            width: 2.5,
          ),
        ),
      ),
      child: TextWidget(
        title: title,
        fontSize: isSelected ? 17 : 16,
        color: isSelected ? getThemeColor() : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
