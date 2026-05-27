// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authModule/provider/auth_provider.dart';
import '../common_functions.dart';
import 'custom_button.dart';

class BottomAlignedWidget extends StatelessWidget {
  final double dW;
  final double dH;
  final Function? onPressed;
  final bool isLoading;
  final String buttonText;
  final double keyBoardHeight;
  final Color bkgColor;
  final Widget? topWidget;

  BottomAlignedWidget({
    super.key,
    required this.dW,
    required this.dH,
    this.onPressed,
    this.topWidget,
    required this.buttonText,
    this.keyBoardHeight = 0,
    this.isLoading = false,
    this.bkgColor = Colors.white,
  });

  Map language = {};

  @override
  Widget build(BuildContext context) {
    language = Provider.of<AuthProvider>(context).selectedLanguage;

    return Container(
      width: dW,
      decoration: BoxDecoration(color: bkgColor, boxShadow: [
        if (bkgColor == Colors.white)
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: const Offset(0, -1),
            spreadRadius: 0,
            blurRadius: 5,
          )
      ]),
      padding: EdgeInsets.only(
        top: dW * 0.02,
        bottom: dW *
            (keyBoardHeight > 50
                ? 0.025
                : iOSCondition(dH)
                    ? 0.07
                    : 0.04),
        left: dW * 0.04,
        right: dW * 0.04,
      ),
      child: Column(
        children: [
          if (topWidget != null) topWidget!,
          CustomButton(
            width: dW * 0.9,
            height: dW * 0.14,
            onPressed: onPressed,
            isLoading: isLoading,
            buttonText: buttonText,
            diabledButtonColor: Colors.green.shade200,
          ),
        ],
      ),
    );
  }
}
