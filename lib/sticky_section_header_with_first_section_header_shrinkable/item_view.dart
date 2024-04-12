

import 'package:flutter/cupertino.dart';

class ItemView extends StatelessWidget {
  final String title;
  const ItemView({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(title),
    );
  }
}