import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authModule/provider/auth_provider.dart';

import '../colors.dart';
import 'asset_svg_icon.dart';

//ignore: must_be_immutable
class FeedbackWidget extends StatelessWidget {
  FeedbackWidget({Key? key}) : super(key: key);

  double dW = 0.0;
  TextTheme customTextTheme = const TextTheme();
  Map language = {};

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    language = Provider.of<AuthProvider>(context).selectedLanguage;
    customTextTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language['giveFeedback'],
          style: customTextTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600, color: getGreyColor2(context)),
        ),
        SizedBox(height: dW * .03),
        Text(
          language['rateYourExperience'],
          style: customTextTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w400, color: getGreyColor2(context)),
        ),
        SizedBox(height: dW * .02),
        Row(
          children: [
            const AssetSvgIcon(iconName: 'star'),
            SizedBox(width: dW * .01),
            const AssetSvgIcon(iconName: 'star'),
            SizedBox(width: dW * .01),
            const AssetSvgIcon(iconName: 'star'),
            SizedBox(width: dW * .01),
            const AssetSvgIcon(iconName: 'star'),
            SizedBox(width: dW * .01),
            const AssetSvgIcon(iconName: 'star'),
            SizedBox(width: dW * .01),
          ],
        )
      ],
    );
  }
}
