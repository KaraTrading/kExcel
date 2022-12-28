import 'package:flutter/material.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/widget/app_text_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about'.translate)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget('aboutUsSub1'.translate,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                AppTextWidget(
                  'aboutUsSub1Desc1'.translate,
                  icon: const Icon(Icons.circle, size: 8),
                ),
                AppTextWidget(
                  'aboutUsSub1Desc2'.translate,
                  icon: const Icon(Icons.circle, size: 8),
                ),
                AppTextWidget(
                  'aboutUsSub1Desc3'.translate,
                  icon: const Icon(Icons.circle, size: 8),
                ),
                AppTextWidget(
                  'aboutUsSub1Desc4'.translate,
                  icon: const Icon(Icons.circle, size: 8),
                ),
                AppTextWidget(
                  'aboutUsSub1Desc5'.translate,
                  icon: const Icon(Icons.circle, size: 8),
                ),
                const SizedBox(height: 16),
                AppTextWidget('aboutUsSub2'.translate,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Text('Copyright © ${DateTime.now().year}'),
          ],
        ),
      ),
    );
  }
}
