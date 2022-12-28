import 'package:flutter/material.dart';

const TextStyle headerTextStyle = TextStyle(fontSize: 18);

const TextStyle titleTextStyle = TextStyle(fontSize: 16);

const TextStyle primaryTextStyle = TextStyle(fontSize: 14);

const TextStyle captionTextStyle = TextStyle(fontSize: 12);

extension TestStyleSize on TextStyle {
  TextStyle get large => copyWith(fontWeight: FontWeight.w700);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w400);
  TextStyle get small => copyWith(fontWeight: FontWeight.w200);
}