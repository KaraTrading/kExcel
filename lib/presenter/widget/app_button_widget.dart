import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? width;
  final IconData? iconData;
  final Color? color;

  const AppButtonWidget(
      this.title,
      this.onPressed, {
        this.width,
        this.iconData,
        this.color,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(color?.withAlpha(10)),
      ),
      onPressed: () => onPressed.call(),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(color: color)),
              if (iconData != null) const SizedBox(width: 4),
              if (iconData != null) Icon(iconData, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
