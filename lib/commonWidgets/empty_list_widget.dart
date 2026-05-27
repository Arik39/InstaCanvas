// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:insta_canvas/colors.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final String subTitle;
  final double topPadding;
  final String image;

  EmptyListWidget({
    Key? key,
    required this.text,
    this.subTitle = '',
    required this.topPadding,
    this.image = '',
    this.textColor,
  }) : super(key: key);

  double dW = 0.0;
  double tS = 0.0;

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.textScalerOf(context).scale(1.0);

    return Container(
      margin: EdgeInsets.only(
        top: dW * topPadding,
        left: dW * 0.05,
        right: dW * 0.05,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != '')
            Container(
              width: dW * 0.65,
              height: dW * 0.5,
              margin: EdgeInsets.only(bottom: dW * 0.1),
              child: Image.asset('assets/images/$image.png'),
            ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: tS * 18,
                  color: textColor ?? getGreyColor2(context),
                ),
            textAlign: TextAlign.center,
          ),
          if (subTitle != '')
            Padding(
              padding: EdgeInsets.only(top: dW * 0.03),
              child: Text(
                subTitle,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: tS * 14,
                      color: const Color(0xff9798A3),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
