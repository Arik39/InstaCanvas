import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authModule/provider/auth_provider.dart';
import '../colors.dart';
import 'asset_svg_icon.dart';

class CustomDropDownMenuWidget extends StatefulWidget {
  final List<String> listOfOptions;
  final int selectedIndex;
  final String label;
  final Function? selectedIndexFunction;
  final TextStyle? labelStyle;
  final TextStyle? selectedOptionStyle;
  final TextStyle? optionStyle;
  final Color? borderColor;
  final Color? bgColor;

  const CustomDropDownMenuWidget({Key? key,
    required this.listOfOptions,
    required this.selectedIndex,
    required this.label,
    this.selectedIndexFunction,
    this.borderColor,
    this.bgColor,
    this.labelStyle,
    this.selectedOptionStyle,
    this.optionStyle})
      : super(key: key);

  @override
  State<CustomDropDownMenuWidget> createState() =>
      _CustomDropDownMenuWidgetState();
}

class _CustomDropDownMenuWidgetState extends State<CustomDropDownMenuWidget> {
  double dH = 0.0;

  double dW = 0.0;

  double tS = 0.0;

  TextTheme customTextTheme = const TextTheme();

  Map language = {};

  bool isLoading = false;
  bool dropDownToggle = false;
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    selectedOption = widget.listOfOptions[widget.selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    dH = MediaQuery
        .of(context)
        .size
        .height;
    dW = MediaQuery
        .of(context)
        .size
        .width;
    tS = MediaQuery
        .of(context)
        .textScaleFactor;
    language = Provider
        .of<AuthProvider>(context)
        .selectedLanguage;
    selectedOption = widget.listOfOptions[widget.selectedIndex];
    customTextTheme = Theme
        .of(context)
        .textTheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          dropDownToggle = !dropDownToggle;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: dW * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: dW * .025),
              child: Text(
                widget.label,
                style: widget.labelStyle ??
                    customTextTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: getGreyColor2(context),
                        fontSize: 12),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.borderColor ?? getLightGreyColor6(context),
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: widget.bgColor ?? getWhiteColor(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: !dropDownToggle,
                    child: Padding(
                      padding: EdgeInsets.all(dW * .03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedOption,
                              style: customTextTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: getGreyColor2(context))),
                          dropDownToggle
                              ? const SizedBox.shrink()
                              : AssetSvgIcon(
                            iconName: 'down_arrow',
                            color: getGreyColor2(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: dropDownToggle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.listOfOptions
                            .map((e) =>
                            GestureDetector(
                              onTap: () {
                                dropDownToggle = false;
                                setState(() {
                                  selectedOption = e;
                                  widget.selectedIndexFunction!(
                                      index:
                                      widget.listOfOptions.indexOf(e),
                                      label: widget.label);
                                });
                              },
                              child: Container(
                                width: dW,
                                color: Colors.transparent,
                                padding: EdgeInsets.all(dW * .03),
                                child: Text(e,
                                    style: e == selectedOption
                                        ? widget.selectedOptionStyle ??
                                        customTextTheme.titleLarge!
                                            .copyWith(
                                            fontWeight:
                                            FontWeight.w600,
                                            color: getGreyColor2(
                                                context))
                                        : widget.optionStyle ??
                                        customTextTheme.titleLarge!
                                            .copyWith(
                                            fontWeight:
                                            FontWeight.w400,
                                            color: getGreyColor2(
                                                context))),
                              ),
                            ))
                            .toList(),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
