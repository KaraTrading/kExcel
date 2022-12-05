import 'package:flutter/material.dart';

class NoItemWidget extends StatelessWidget {
  const NoItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('0 Item founded'),
    );
  }
}
