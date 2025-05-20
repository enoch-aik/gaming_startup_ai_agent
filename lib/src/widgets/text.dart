import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/src/res/styles/styles.dart';

class KText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? lineHeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontStyle? fontStyle;
  final String? fontFamily;

  const KText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.lineHeight,
    this.textAlign,
    this.decoration,
    this.overflow,
    this.maxLines,
    this.fontStyle,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: AppStyles.textStyle.copyWith(
        decoration: decoration,
        fontSize: fontSize,
        fontWeight: fontWeight /*?? FontWeight.w300*/,
        color: color,
        height: lineHeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily
      ),
    );
  }
}
