import 'package:flutter/material.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';

TextStyle get headerTextStyle => TextStyle(
  fontSize: 18,
  color: textPrimaryColor,
);

TextStyle get titleTextStyle => TextStyle(
  fontSize: 16,
  color: textPrimaryColor,
);

TextStyle get primaryTextStyle => TextStyle(
  fontSize: 14,
  color: textPrimaryColor,
);

TextStyle get captionTextStyle => TextStyle(
  fontSize: 12,
  color: textCaptionColor,
);

extension TestStyleColor on TextStyle {
  TextStyle get onPrimary => copyWith(color: onPrimaryColor);
}
extension TestStyleSize on TextStyle {
  TextStyle get large => copyWith(fontWeight: FontWeight.w700);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w400);
  TextStyle get small => copyWith(fontWeight: FontWeight.w200);
}