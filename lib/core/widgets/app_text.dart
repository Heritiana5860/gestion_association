import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.label,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.wordSpacing,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.textAlign,
  });

  final String label;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? wordSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Inter',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
