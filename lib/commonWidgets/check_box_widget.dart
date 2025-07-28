import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final double borderRadius;
  final double height;
  final double? borderWidth;
  final double? constraintWidth;
  final double iconSize;
  final bool active;
  final Color? iconColor;
  final Color? activeColor;
  final Color? activeBorderColor;
  final Color? inActiveBorderColor;
  final String? title;

  final FontWeight? textFontWeight;
  final Color? textColor;
  final double? fontSize;
  final Function onTap;

  const CheckBoxWidget({
    Key? key,
    required this.active,
    required this.borderRadius,
    required this.height,
    this.constraintWidth = .4,
    required this.iconSize,
    this.title = '',
    this.iconColor = Colors.white,
    this.activeColor = Colors.blue,
    this.activeBorderColor = Colors.blue,
    this.inActiveBorderColor = const Color(0xff828080),
    this.textFontWeight = FontWeight.w600,
    this.textColor = Colors.black,
    this.fontSize = 14.0,
    this.borderWidth = 0.75,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                color: active ? activeColor! : Colors.transparent,
                border: active
                    ? Border.all(
                        color: activeBorderColor!,
                        width: borderWidth!,
                      )
                    : Border.all(
                        color: inActiveBorderColor!,
                        width: borderWidth!,
                      ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: active
                  ? Icon(
                      Icons.check_rounded,
                      size: iconSize,
                      color: iconColor,
                    )
                  : null,
            ),
            if (title != '')
              Container(
                width: constraintWidth == null
                    ? null
                    : deviceWidth * constraintWidth!,
                // constraints:
                //     BoxConstraints(maxWidth: deviceWidth * constraintWidth),
                margin: EdgeInsets.only(left: deviceWidth * 0.035),
                child: Text(
                  '$title',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: textFontWeight,
                        color: textColor,
                        fontSize: textScaleFactor * fontSize!,
                        letterSpacing: .5,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
