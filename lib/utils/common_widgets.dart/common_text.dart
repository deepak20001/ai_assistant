import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// ::::: Common Text :::::
class CommonText extends StatefulWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final Size? size;
  final Color? color;
  final bool isHashTag;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  // Color shadowColor;
  final double dx;
  final double dy;
  final double? letterSpacing;
  final int? maxLine;
  final double topSpacing;
  final double bottomSpacing;
  final double leftSpacing;
  final double rightSpacing;

  const CommonText({
    super.key,
    required this.title,
    this.isHashTag = false,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.textAlign,
    this.fontFamily,
    this.overflow,
    this.size,
    this.letterSpacing,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    // this.shadowColor = Colors.transparent,
    this.dx = 0,
    this.dy = 0,
    this.maxLine,
    this.topSpacing = 0,
    this.bottomSpacing = 0,
    this.leftSpacing = 0,
    this.rightSpacing = 0,
  });

  @override
  State<CommonText> createState() => _CommonTextState();
}

class _CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.topSpacing,
        bottom: widget.bottomSpacing,
        left: widget.leftSpacing,
        right: widget.rightSpacing,
      ),
      child: normalField(),
    );
  }

  Widget normalField() {
    return Text(
      widget.title,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
      maxLines: widget.maxLine,
      style: commonTextStyle(),
    );
  }

  TextStyle commonTextStyle({Color? color}) {
    return TextStyle(
      decorationColor: widget.decorationColor,
      /*  shadows: [
        Shadow(offset: Offset(widget.dx, widget.dy), color: widget.shadowColor)
      ], */
      decoration: widget.decoration,
      // fontFamily: CommonTextStyle.fontFamily,
      letterSpacing: widget.letterSpacing,
      fontStyle: FontStyle.normal,
      fontSize: widget.fontSize,
      fontWeight: widget.fontWeight,
      color: widget.color,
    );
  }
}
