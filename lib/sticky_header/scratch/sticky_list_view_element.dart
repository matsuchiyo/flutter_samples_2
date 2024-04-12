
import 'package:flutter/cupertino.dart';

sealed class StickyListViewElement {}
class NormalItem extends StickyListViewElement {
  Widget Function(BuildContext context) builder;
  NormalItem({required this.builder});
}
class StickyItem extends StickyListViewElement {
  Widget Function(BuildContext context) builder;
  StickyItem({required this.builder});
}