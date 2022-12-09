import 'package:flutter/material.dart';

Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isScrollControlled = false,
  bool isDismissible = true,
  bool showCloseIcon = false,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.only(
        left: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (title != null && title.isNotEmpty) ? Text(title) : Container(),
                  (showCloseIcon)
                      ? IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        )
                      :const SizedBox()
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}
