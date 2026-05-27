import 'package:flutter/material.dart';

import '../common_functions.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double hPadding;
  final double vPadding;
  final double borderWidth;
  final Color? borderColor;
  final double? width;
  final Color bgColor;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;
  const CustomContainer({
    super.key,
    required this.child,
    this.margin,
    this.radius = 10,
    this.hPadding = 0.045,
    this.vPadding = 0.04,
    this.borderColor,
    this.borderWidth = 1,
    this.width,
    this.bgColor = Colors.transparent,
    this.boxShadow,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;

    return Container(
      margin: margin,
      width: width ?? dW,
      alignment: alignment,
      padding: EdgeInsets.symmetric(
        horizontal: dW * hPadding,
        vertical: dW * vPadding,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? getThemeColor().withValues(alpha: .2),
          width: borderWidth,
        ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(3, 3),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //
            ],
      ),
      child: child,
    );
  }
}
