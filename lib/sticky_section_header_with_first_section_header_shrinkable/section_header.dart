

import 'package:flutter/cupertino.dart';

class SectionHeader extends StatelessWidget {
  static const height = 24.0;
  final String title;
  const SectionHeader({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
      color: const Color(0x880000FF),
      alignment: Alignment.bottomLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF000000),
        ),
      ),
    );
  }
}