// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../colors.dart';
import 'asset_svg_icon.dart';
import 'text_widget.dart';

//ignore: must_be_immutable
class RowTextIcon extends StatelessWidget {
  final double dW;
  final String title;
  final String icon;
  final Function navigateTo;
  bool showBorder;
  double? iconSize;
  Widget? widget;
  RowTextIcon({
    super.key,
    this.iconSize,
    required this.dW,
    required this.title,
    required this.icon,
    required this.navigateTo,
    this.widget,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: dW * 0.03),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: !showBorder
              ? null
              : const Border(bottom: BorderSide(color: Color(0xffEFEFEF))),
        ),
        margin: EdgeInsets.only(bottom: dW * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AssetSvgIcon(iconName: icon, height: iconSize),
                    SizedBox(width: dW * 0.04),
                    TextWidget(
                      title: title,
                      fontSize: 14,
                      color: const Color(0xff434343),
                      fontWeight: FontWeight.w400,
                      letterSpacing: .3,
                    )
                  ],
                ),
                widget ??
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: getGreyColor3(context),
                    )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
