import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

customDialogBox({
  String? title,
  TextStyle? titleStyle,
  String? content,
  TextStyle? contentStyle,
  String? cancelBtnText,
  TextStyle? cancelBtnStyle,
  Function? cancelBtnPress,
  String? okBtnText,
  TextStyle? okBtnStyle,
  Function? okBtnPress,
  BuildContext? context,
  bool barrierDismissible = true,
}) {
  return Platform.isIOS
      ? showCupertinoDialog(
          barrierDismissible: barrierDismissible,
          context: context!,
          builder: (context) => CupertinoAlertDialog(
            title: title == null
                ? const SizedBox.shrink()
                : Text(
                    title,
                    style: titleStyle,
                  ),
            content: Text(content!, style: contentStyle),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  okBtnText!,
                  style: okBtnStyle,
                ),
                onPressed: () => okBtnPress!(),
              ),
              if (cancelBtnText != null)
                CupertinoDialogAction(
                  child: Text(
                    cancelBtnText,
                    style: cancelBtnStyle,
                  ),
                  onPressed: () => cancelBtnPress!(),
                ),
            ],
          ),
        )
      : showDialog(
          context: context!,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: title == null
                ? const SizedBox.shrink()
                : Text(
                    title,
                    style: titleStyle,
                  ),
            content: Text(content!, style: contentStyle),
            actions: [
              TextButton(
                style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                onPressed: () => okBtnPress!(),
                child: Text(
                  okBtnText!,
                  style: okBtnStyle,
                ),
              ),
              if (cancelBtnText != null)
                TextButton(
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  onPressed: () => cancelBtnPress!(),
                  child: Text(
                    cancelBtnText,
                    style: cancelBtnStyle,
                  ),
                ),
            ],
          ),
        );
}
