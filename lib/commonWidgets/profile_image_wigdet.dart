import 'package:flutter/material.dart';
import '../common_functions.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.dW,
    required this.image,
    required this.fullName,
    this.radius,
  });

  final String fullName;
  final double dW;
  final String image;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        child: image != '' && image.contains('https')
            ? ClipOval(
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: dW,
                  height: dW,
                ),
              )
            : Text(
                getInitials(fullName),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: getThemeColor(),
                ),
              ),
      ),
    );
  }
}
