import 'package:flutter/material.dart';

import '../common_functions.dart';
import 'asset_svg_icon.dart';

class CustomFrwdButton extends StatelessWidget {
  const CustomFrwdButton({Key? key, this.color, this.onTap}) : super(key: key);

  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AssetSvgIcon(
      onTap: onTap,
      iconName: 'frwd_arrow',
      color: color ?? getThemeColor(),
    );
  }
}
