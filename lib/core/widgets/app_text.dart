import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.dmSans(
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
