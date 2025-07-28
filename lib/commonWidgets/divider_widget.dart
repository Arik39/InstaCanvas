import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double top;
  final double bottom;
  final Color? color;
  final double? thickness;
  const DividerWidget({
    super.key,
    this.top = 10,
    this.bottom = 10,
    this.color, //= getGreyColor(context)
    this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: top,
        bottom: bottom,
      ),
      child: Divider(
        color: color,
        thickness: thickness,
      ),
    );
  }
}
