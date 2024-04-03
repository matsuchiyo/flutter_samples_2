
import 'package:flutter/cupertino.dart';

class MyToolbar extends StatelessWidget {
  static const height = 56.0;
  final void Function() onCompleteTap;
  final void Function()? onCancelTap;

  const MyToolbar({
    super.key,
    required this.onCompleteTap,
    this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD6D8DD),
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          onCancelTap == null ? const SizedBox() : CupertinoButton(
            onPressed: () => onCancelTap?.call(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          CupertinoButton(
            onPressed: onCompleteTap,
            child: Text(
              'Complete',
              style: TextStyle(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}