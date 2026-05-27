import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import 'text_widget.dart';
import '../common_functions.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? minLines;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatter;
  final Function? onTap;
  final Function? onChanged;
  final Function? validator;
  final bool enabled;
  final Widget? widget;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final double labelFS;
  final double hintFS;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final bool optional;
  final Color labelColor;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintTextColor;
  final TextStyle? textStyle;
  const CustomTextFieldWithLabel({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.minLines,
    this.maxLength,
    this.maxLines,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.inputFormatter,
    this.onTap,
    this.onChanged,
    this.validator,
    this.inputAction = TextInputAction.done,
    this.enabled = true,
    this.widget,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.labelFS = 14,
    this.hintFS = 16,
    this.optional = false,
    this.labelColor = const Color(0xFF3E3E3E),
    this.borderColor,
    this.fillColor,
    this.hintTextColor,
    this.prefixIconConstraints,
    this.textStyle,
  });

  textFormBorder(context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        // color: !enabled ? getThemeColor().withOpacity(.25) : getThemeColor(),
        width: 1,
        color: borderColor ?? getLightGreyColor1(context),
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tS = MediaQuery.textScalerOf(context).scale(1.0);
    final double dW = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (label != '')
              Row(
                children: [
                  TextWidget(
                    title: label,
                    fontSize: labelFS,
                    color: labelColor,
                  ),
                  if (!optional)
                    TextWidget(
                      title: '*',
                      fontSize: labelFS,
                      color: getRedColor1(context),
                    ),
                ],
              ),
            if (widget != null) widget!,
          ],
        ),
        if (label != '') SizedBox(height: dW * 0.025),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onTap: onTap != null ? () => onTap!() : null,
          inputFormatters: inputFormatter,
          textCapitalization: textCapitalization,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enabled,
          textAlign: textAlign,
          style: textStyle ??
              Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: tS * 16,
                  letterSpacing: .3,
                  fontWeight: FontWeight.w500),
          cursorColor: getThemeColor(),
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: tS * hintFS,
              letterSpacing: .3,
              color: hintTextColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: dW * 0.045,
              vertical: dW * 0.035,
            ),
            border: textFormBorder(context),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: textFormBorder(context),
            errorBorder: textFormBorder(context),
            disabledBorder: textFormBorder(context),
            focusedErrorBorder: textFormBorder(context),
            counterText: '',
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints,
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
          ),
          minLines: minLines,
          maxLength: maxLength,
          maxLines: maxLines,
          textInputAction: inputAction,
          keyboardType: inputType,
          onChanged: onChanged != null ? (value) => onChanged!(value) : null,
          validator: validator != null ? (value) => validator!(value) : null,
        ),
      ],
    );
  }
}
