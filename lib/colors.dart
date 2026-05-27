import 'package:flutter/material.dart';

Color getPrimaryColor(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF0F130E); // Dark mode color
  }
}

const Color greenPrimary = Color(0xFF10B981);
Color disabledColor = const Color(0xFF4A9F63).withValues(alpha: .5);

// Custom back Button
Color getAppBackground(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF111111); // Dark mode color
  }
}

Color getSubTitle(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF505050); // Dark mode color
  }
}

Color getIcon(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF505050); // Dark mode color
  }
}

Color getTextFieldBackground(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF191919); // Dark mode color
  }
}

Color getHintText(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF313131); // Dark mode color
  }
}

Color getDivider(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF151515); // Dark mode color
  }
}

Color getSuffixIcon(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF444444); // Dark mode color
  }
}

//                                                    //
//                                                    //
//                                                    //
//Old Colors
// Custom back Button
Color getCustomBackIconBgColor(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    return const Color(0xFF212B1E); // Dark mode color
  }
}

Color getCustomBackIconColor(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF292D32); // Light mode color
  } else {
    return const Color(0xFFFFFFFF); // Dark mode color
  }
}

Color getGreyColor(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFD4D4D4); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFD4D4D4); // Example dark mode color
  }
}

Color getGreyColor2(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF5E5E5E); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFFFFFFF); // Example dark mode color
  }
}

Color getGreyColor3(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF6B6C75); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFFFFFFF); // Example dark mode color
  }
}

Color getGreyColor4(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF636363); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFF53A63A); // Example dark mode color
  }
}

Color getGreyColor8(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF3E3E3E); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFFFFFFF); // Example dark mode color
  }
}

Color getBlackColor2(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF37383F); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFF37383F); // Example dark mode color
  }
}

Color getWhiteColor(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFFFFFFF); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFF181F17); // Example dark mode color
  }
}

Color getRedColor1(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFEF4444); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFFFFFFF); // Example dark mode color
  }
}

Color getPrimaryFadeBorder(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF72CD95).withValues(alpha: 0.4); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFFFFFFF); // Example dark mode color
  }
}

Color getLightGreyColor1(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFACACB4); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFFFFFFFF); // Example dark mode color
  }
}

Color getLightGreyColor6(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFD9D9D9); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFF3E3E3E); // Example dark mode color
  }
}

Color getLightGreenColor1(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFFE3FEDB); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFF374D31); // Example dark mode color
  }
}

Color getTextFieldGreenHintTextColor(BuildContext context) {
  final themeMode = Theme.of(context).brightness;

  if (themeMode == Brightness.light) {
    return const Color(0xFF4A9434); // Light mode color
  } else {
    // Handle dark mode color here
    return const Color(0xFF4A9434); // Example dark mode color
  }
}
