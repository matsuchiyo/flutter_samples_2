
import 'package:flutter/cupertino.dart';

sealed class Element {
  final Widget Function(BuildContext context) builder;
  Element({
    required this.builder,
  });
}

class NormalItem extends Element {
  NormalItem({
    required super.builder,
  });
}

class StickyItem extends Element {
  StickyItem({
    required super.builder,
  });
}
