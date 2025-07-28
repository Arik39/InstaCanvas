import 'package:flutter/material.dart';

import '../colors.dart';
import '../common_functions.dart';
import 'circular_loader.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Function? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? borderColor;
  final Color textColor;
  final Color? diabledButtonColor;
  final Color loaderColor;
  final TextStyle? buttonTextSyle;
  final bool isLoading;
  final double bottomMargin;
  final double? elevation;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    this.radius = 10,
    this.onPressed,
    this.elevation,
    required this.buttonText,
    this.buttonColor,
    this.borderColor,
    this.diabledButtonColor,
    this.buttonTextSyle,
    this.isLoading = false,
    this.bottomMargin = 0,
    this.textColor = Colors.white,
    this.loaderColor = Colors.white,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final double tS = MediaQuery.of(context).textScaleFactor;
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: borderColor == null
          ? null
          : BoxDecoration(
              border: Border.all(color: borderColor!),
              borderRadius: BorderRadius.circular(radius),
            ),
      child: ElevatedButton(
        onPressed: onPressed == null ? null : () => onPressed!(),
        style: ElevatedButton.styleFrom(
          elevation: buttonColor != Colors.transparent ? elevation : 0,
          backgroundColor: buttonColor ?? getThemeColor(),
          disabledBackgroundColor: diabledButtonColor ?? disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Center(
          child: isLoading
              ? circularForButton(width * 0.06, color: loaderColor)
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    buttonText,
                    style: buttonTextSyle ??
                        Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: tS * fontSize,
                              color: textColor,
                            ),
                  ),
                ),
        ),
      ),
    );
  }
}
