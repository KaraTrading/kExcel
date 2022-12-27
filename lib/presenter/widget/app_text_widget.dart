import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Icon? icon;

  const AppTextWidget(
    this.text, {
    this.icon,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return (icon != null)
        ? Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: icon!,
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(text: text, style: style)
              ],
            ),
          )
        : Text(text, style: style);
  }
}
