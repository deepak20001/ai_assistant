import 'package:ai_assistant/utils/common_const.dart';
import 'package:flutter/material.dart';

final

    /// ::::: Common Text FormField :::::
    class CommonTextFormField extends StatefulWidget {
  final Size size;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final double borderWidth;
  final String? labelText;
  final List<Map<String, dynamic>>? hashTag;
  final Function()? onTap;
  final Color borderColor;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? suffixIcon;
  final String? suffixText;
  final String hintText;
  final String errorText;
  final double textSize;
  final double? fontTextSize;
  final double? containerHeight;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool showCounterText;
  final bool isRead;
  final bool isObscure;
  final bool isConstrains;
  final double borderRadius;
  final String? Function(String?)? validation;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onDetached;
  final Function()? onDetectedCompleted;
  final Function(String)? onDone;
  final bool isDetectable;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;

  const CommonTextFormField({
    super.key,
    required this.size,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.suffixText,
    this.maxLines,
    this.maxLength,
    this.hashTag,
    this.keyboardType,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.onDetached,
    this.onDetectedCompleted,
    this.onTap,
    this.validation,
    this.isDetectable = false,
    this.textSize = numD04,
    this.fontTextSize = numD04,
    this.containerHeight = 0.07,
    this.textColor,
    this.hintTextColor,
    this.fillColor,
    this.borderWidth = numD001,
    this.borderColor = Colors.black,
    this.errorText = '',
    this.isRead = false,
    this.showCounterText = false,
    this.isObscure = false,
    this.isConstrains = false,
    this.enabled = false,
    this.borderRadius = numD05,
    this.labelText,
    this.onChange,
    this.onDone,
    this.textCapitalization,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return normalFiledWidget();
  }

  Widget normalFiledWidget() {
    return TextFormField(
      textCapitalization:
          widget.textCapitalization ?? TextCapitalization.sentences,
      keyboardAppearance: Brightness.light,
      // cursorColor: CommonColors.themeColor,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      readOnly: widget.isRead,
      onTap: widget.onTap,
      maxLines: widget.isObscure ? 1 : widget.maxLines,
      maxLength: widget.maxLength,
      autocorrect: false,
      obscureText: widget.isObscure,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChange,
      onFieldSubmitted: widget.onDone,
      textInputAction: widget.textInputAction,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: widget.size.width * widget.fontTextSize!,
        // fontFamily: CommonTextStyle.fontFamily,
        fontStyle: FontStyle.normal,
        color: widget.textColor ?? Colors.black,
      ),
      validator: widget.validation,
      decoration: commonDecoration(widget.showCounterText),
    );
  }

  InputDecoration commonDecoration(bool showCounterText) {
    return InputDecoration(
      counterText: showCounterText ? null : "",
      hintText: widget.hintText,
      contentPadding: EdgeInsets.symmetric(
          horizontal: widget.size.width * numD035,
          vertical: widget.size.width * numD040),
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: widget.isConstrains
          ? const BoxConstraints(
              minWidth: 25,
              minHeight: 25,
            )
          : const BoxConstraints(
              minWidth: 50,
              minHeight: 50,
            ),
      prefix: widget.prefixWidget,
      suffixIcon: widget.suffixIcon,
      suffixText: widget.suffixText,
      suffixStyle: const TextStyle(color: Colors.grey),
      suffix: widget.suffixWidget,
      hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: widget.size.width * numD035,
          // fontFamily: CommonTextStyle.fontFamily,
          color: widget.hintTextColor ?? Colors.grey),
      labelText: widget.labelText,
      labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: widget.textSize,
          // fontFamily: CommonTextStyle.fontFamily,
          color: Colors.black),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: widget.fillColor ?? Colors.white,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.0, color: Colors.black),
        borderRadius: BorderRadius.circular(num8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.0, color: Colors.black),
        borderRadius: BorderRadius.circular(num8),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(num8)),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 0),
        borderRadius: BorderRadius.circular(num8),
      ),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(num8)),
    );
  }
}
