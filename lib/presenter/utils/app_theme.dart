import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'text_styles.dart';

TextTheme _textThemeLight = TextTheme(
  displayLarge: headerTextStyle.medium.copyWith(color: textPrimaryColorLight),
  displayMedium: titleTextStyle.medium.copyWith(color: textPrimaryColorLight),
  displaySmall: captionTextStyle.medium.copyWith(color: textCaptionColorLight),
  headlineLarge: headerTextStyle.large.copyWith(color: textPrimaryColorLight),
  headlineMedium: headerTextStyle.medium.copyWith(color: textPrimaryColorLight),
  headlineSmall: headerTextStyle.small.copyWith(color: textPrimaryColorLight),
  titleLarge: titleTextStyle.large.copyWith(color: textPrimaryColorLight),
  titleMedium: titleTextStyle.medium.copyWith(color: textPrimaryColorLight),
  titleSmall: titleTextStyle.small.copyWith(color: textPrimaryColorLight),
  bodyLarge: primaryTextStyle.large.copyWith(color: textPrimaryColorLight),
  bodyMedium: primaryTextStyle.medium.copyWith(color: textPrimaryColorLight),
  bodySmall: primaryTextStyle.small.copyWith(color: textPrimaryColorLight),
  labelLarge: captionTextStyle.large.copyWith(color: textCaptionColorLight),
  labelMedium: captionTextStyle.medium.copyWith(color: textCaptionColorLight),
  labelSmall: captionTextStyle.small.copyWith(color: textCaptionColorLight),
);

TextTheme _textThemeDark = TextTheme(
  displayLarge: headerTextStyle.medium.copyWith(color: textPrimaryColorDark),
  displayMedium: titleTextStyle.medium.copyWith(color: textPrimaryColorDark),
  displaySmall: captionTextStyle.medium.copyWith(color: textCaptionColorDark),
  headlineLarge: headerTextStyle.large.copyWith(color: textPrimaryColorDark),
  headlineMedium: headerTextStyle.medium.copyWith(color: textPrimaryColorDark),
  headlineSmall: headerTextStyle.small.copyWith(color: textPrimaryColorDark),
  titleLarge: titleTextStyle.large.copyWith(color: textPrimaryColorDark),
  titleMedium: titleTextStyle.medium.copyWith(color: textPrimaryColorDark),
  titleSmall: titleTextStyle.small.copyWith(color: textPrimaryColorDark),
  bodyLarge: primaryTextStyle.large.copyWith(color: textPrimaryColorDark),
  bodyMedium: primaryTextStyle.medium.copyWith(color: textPrimaryColorDark),
  bodySmall: primaryTextStyle.small.copyWith(color: textPrimaryColorDark),
  labelLarge: captionTextStyle.large.copyWith(color: textCaptionColorDark),
  labelMedium: captionTextStyle.medium.copyWith(color: textCaptionColorDark),
  labelSmall: captionTextStyle.small.copyWith(color: textCaptionColorDark),
);

ThemeData appThemeLight = ThemeData(
  useMaterial3: true,
  colorScheme: _colorSchemeLight,
  textTheme: _textThemeLight,
);

ThemeData appThemeDark = ThemeData(
  useMaterial3: true,
  colorScheme: _colorSchemeDark,
  textTheme: _textThemeDark,
);

const _colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: primaryColorLight,
  onPrimary: onPrimaryColorLight,
  secondary: secondaryColorLight,
  onSecondary: onSecondaryColorLight,
  primaryContainer: primaryContainerColorLight,
  error: Colors.black,
  onError: Colors.white,
  background: backgroundColorLight,
  onBackground: onBackgroundColorLight,
  surface: surfaceColorLight,
  onSurface: onSurfaceColorLight,
);

const _colorSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: primaryColorDark,
  onPrimary: onPrimaryColorDark,
  secondary: secondaryColorDark,
  onSecondary: onSecondaryColorDark,
  primaryContainer: primaryColorDark,
  error: Colors.black,
  onError: Colors.white,
  background: backgroundColorDark,
  onBackground: obBackgroundColorDark,
  surface: surfaceColorDark,
  onSurface: onSurfaceColorDark,
);
