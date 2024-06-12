import 'package:ai_assistant/utils/common_const.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_text.dart';
import 'package:flutter/material.dart';

/// Common Text button ::
Widget commonTextButton({
  required Function() onTap,
  required Size size,
  required String buttonText,
  double? radius,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      child: CommonText(
        title: buttonText,
        fontSize: fontSize ?? size.width * numD035,
        fontWeight: fontWeight ?? FontWeight.w400,
        textAlign: TextAlign.center,
        color: color ?? Colors.black,
      ));
}