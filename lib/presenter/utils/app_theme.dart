import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'text_styles.dart';

ThemeData get appTheme => ThemeData(
      primarySwatch: Colors.green,
      appBarTheme: AppBarTheme(
        titleTextStyle: headerTextStyle.large.onPrimary,
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 1,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryDarkerColor,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: headerTextStyle.medium,
        displayMedium: titleTextStyle.medium,
        displaySmall: captionTextStyle.medium,
        headlineLarge: headerTextStyle.large,
        headlineMedium: headerTextStyle.medium,
        headlineSmall: headerTextStyle.small,
        titleLarge: titleTextStyle.large,
        titleMedium: titleTextStyle.medium,
        titleSmall: titleTextStyle.small,
        bodyLarge: primaryTextStyle.large,
        bodyMedium: primaryTextStyle.medium,
        bodySmall: primaryTextStyle.small,
        labelLarge: captionTextStyle.large,
        labelMedium: captionTextStyle.medium,
        labelSmall: captionTextStyle.small,
      ),
    );
