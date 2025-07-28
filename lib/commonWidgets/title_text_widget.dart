import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;

  const TitleText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    double dW = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(bottom: dW * 0.06, top: dW * 0.01),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: fontSize,
              color: color,
            ),
      ),
    );
  }
}
