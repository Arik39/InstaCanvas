import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvgIcon extends StatelessWidget {
  final String iconName;
  final Color? color;
  final double? height;
  final double? width;
  final Function? onTap;

  const AssetSvgIcon({
    super.key,
    required this.iconName,
    this.color,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(),
      child: SvgPicture.asset(
        'assets/svgIcons/$iconName.svg',
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
        height: height,
        width: width,
      ),
    );
  }
}
