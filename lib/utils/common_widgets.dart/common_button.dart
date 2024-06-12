import 'package:ai_assistant/utils/common_const.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_text.dart';
import 'package:flutter/material.dart';

/// ::::: Common Button :::::
class CommonButton extends StatefulWidget {
  final Function() onTap;
  final String buttonText;
  final double? radius;
  final double buttonSize;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const CommonButton({
    super.key,
    required this.onTap,
    this.radius,
    this.fontWeight = FontWeight.w400,
    this.buttonSize = numD04,
    required this.buttonText,
    this.borderColor,
    this.buttonColor,
    this.buttonTextColor,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(size.width * (widget.radius ?? numD08)),
        gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.transparent]),
      ),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                size.width * (widget.radius ?? numD01),
              ),
              side: const BorderSide(
                  // color: widget.borderColor ?? CommonColors.themeColor,
                  ),
            ),
            backgroundColor: widget.buttonColor ?? Colors.black,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: size.width * numD03)),
        child: CommonText(
          title: widget.buttonText,
          fontSize: size.width * numD05,
          color: widget.buttonTextColor ?? Colors.white,
        ),
      ),
    );
  }
}
