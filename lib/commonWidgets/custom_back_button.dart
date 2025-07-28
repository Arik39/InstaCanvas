// ignore_for_file: must_be_immutable

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authModule/provider/auth_provider.dart';
import '../colors.dart';
import '../navigation/navigators.dart';

class CustomBackButton extends StatelessWidget {
  final double dW;

  CustomBackButton({super.key, required this.dW});

  Map language = {};

  @override
  Widget build(BuildContext context) {
    language = Provider.of<AuthProvider>(context).selectedLanguage;

    return GestureDetector(
      onTap: () => pop(),
      child: Container(
        height: dW * 0.125,
        width: dW * 0.125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xffF2F2F2),
        ),
        child: Center(
          child: Platform.isIOS
              ? Icon(Icons.arrow_back_ios_new_rounded,
                  size: 22, color: getGreyColor4(context))
              : Icon(Icons.arrow_back, color: getGreyColor4(context)),
        ),
      ),
    );
  }
}
