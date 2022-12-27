import 'package:flutter/material.dart';
import 'package:kexcel/presenter/common/localization.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about'.translate)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Project Management of KARA Industrial Trading GmbH & Metpool GmbH\nManaging projects, import items from excel, manage and export data.'),
          Text('Copyright © ${DateTime.now().year}'),
        ],
      ),
    );
  }
}
