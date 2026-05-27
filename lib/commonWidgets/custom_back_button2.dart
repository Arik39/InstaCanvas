// ignore_for_file: must_be_immutable

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authModule/provider/auth_provider.dart';
import '../colors.dart';
import '../navigation/navigators.dart';

class CustomBackButton2 extends StatelessWidget {
  final double dW;
  final Color? backgroundColor;
  final Color? iconColor;
  final Function? actionMethod;

  CustomBackButton2({
    super.key,
    required this.dW,
    this.backgroundColor,
    this.iconColor,
    this.actionMethod,
  });

  Map language = {};

  @override
  Widget build(BuildContext context) {
    language = Provider.of<AuthProvider>(context).selectedLanguage;

    return GestureDetector(
      onTap: () => actionMethod == null ? pop() : actionMethod!(),
      child: Container(
        height: dW * 0.1,
        width: dW * 0.1,
        decoration: BoxDecoration(
          color: backgroundColor ?? getCustomBackIconBgColor(context),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: .15),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Platform.isIOS
              ? Icon(Icons.arrow_back_ios_new_rounded,
                  size: 22, color: iconColor ?? getCustomBackIconColor(context))
              : Icon(Icons.arrow_back,
                  color: iconColor ?? getCustomBackIconColor(context)),
        ),
      ),
    );
  }
}
