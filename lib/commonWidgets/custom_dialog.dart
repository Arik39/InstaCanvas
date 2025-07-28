import 'package:flutter/material.dart';

import '../colors.dart';
import '../common_functions.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String noText;
  final String yesText;
  final Function yesFunction;
  final Function noFunction;

  const CustomDialog({
    Key? key,
    required this.subTitle,
    required this.noText,
    required this.yesText,
    required this.noFunction,
    required this.yesFunction,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dW = MediaQuery.of(context).size.width;
    final double tS = MediaQuery.of(context).textScaleFactor;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      titlePadding: EdgeInsets.symmetric(
        horizontal: dW * 0.05,
        vertical: dW * 0.05,
      ),
      title: SizedBox(
        width: dW,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: getThemeColor()),
            ),
            SizedBox(height: dW * .03),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                subTitle,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: getGreyColor8(context)),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: dW * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      yesFunction();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: dW * 0.04, vertical: dW * 0.02),
                      decoration: BoxDecoration(
                        color: getLightGreenColor1(context),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        yesText,
                        style: TextStyle(
                          color: getGreyColor8(context),
                          fontSize: tS * 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: dW * 0.04),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      noFunction();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: dW * 0.04, vertical: dW * 0.02),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        noText,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: getWhiteColor(context),
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      titleTextStyle: Theme.of(context)
          .textTheme
          .displayLarge!
          .copyWith(fontSize: tS * 14, color: getBlackColor2(context)),
    );
  }
}
