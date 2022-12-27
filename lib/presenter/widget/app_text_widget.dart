import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final Icon? icon;

  const AppTextWidget(
    this.text, {
    this.icon,
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
                TextSpan(text: text)
              ],
            ),
          )
        : Text(text);
  }
}
