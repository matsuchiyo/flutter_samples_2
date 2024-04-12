
import 'package:flutter/cupertino.dart';
import 'package:flutter_samples_2/sticky_section_header_with_first_section_header_shrinkable/element.dart';

class StickyItemView extends StatefulWidget {
  final ScrollController scrollController;
  final StickyItem item;
  final StickyItem? previousStickyItem;
  final double marginTopOfStickyItem;
  final void Function(StickyItem? stickyItem) onCurrentStickyItemChanged;
  final void Function(bool isPreviousStickyItemVisible) onPreviousStickyItemVisibilityChanged;

  const StickyItemView({
    super.key,
    required this.scrollController,
    required this.item,
    required this.previousStickyItem,
    required this.marginTopOfStickyItem,
    required this.onCurrentStickyItemChanged,
    required this.onPreviousStickyItemVisibilityChanged,
  });

  @override
  State<StickyItemView> createState() => _StickyItemViewState();
}

class _StickyItemViewState extends State<StickyItemView> {
  bool isThisStickyItemVisible = true;
  bool isPreviousStickyItemVisible = false;
  final key = GlobalKey();
  final keyForDummyPreviousStickyItem = GlobalKey();
  VoidCallback? _scrollControllerListener;

  @override
  void initState() {
    super.initState();
    _scrollControllerListener = () {
      bool isPreviousStickyItemVisibleTemp = isPreviousStickyItemVisible;
      bool isThisStickyItemVisibleTemp = isThisStickyItemVisible;

      if (widget.previousStickyItem != null) {
        final RenderBox? renderBox = keyForDummyPreviousStickyItem.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final leftTop = renderBox.localToGlobal(Offset.zero);
          final rightBottom = renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero));
          final isPreviousTopOverThanScreenTop = leftTop.dy <= widget.marginTopOfStickyItem;
          isPreviousStickyItemVisibleTemp = isPreviousTopOverThanScreenTop;
        }
      }

      final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final leftTop = renderBox.localToGlobal(Offset.zero);
        final rightBottom = renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero));
        final isCurrentTopUnderThanScreenTop = leftTop.dy >= widget.marginTopOfStickyItem;
        isThisStickyItemVisibleTemp = isCurrentTopUnderThanScreenTop;
      }

      if (
        isPreviousStickyItemVisibleTemp != isPreviousStickyItemVisible ||
        isThisStickyItemVisibleTemp != isThisStickyItemVisible
      ) {
        setState(() {
          isPreviousStickyItemVisible = isPreviousStickyItemVisibleTemp;
          isThisStickyItemVisible = isThisStickyItemVisibleTemp;
        });
        widget.onCurrentStickyItemChanged(isThisStickyItemVisibleTemp ? (isPreviousStickyItemVisibleTemp ? null : widget.previousStickyItem) : widget.item);
        widget.onPreviousStickyItemVisibilityChanged(isPreviousStickyItemVisibleTemp);
      }
    };
    widget.scrollController.addListener(_scrollControllerListener!);
  }

  @override
  void dispose() {
    final scrollControllerListener = _scrollControllerListener;
    if (scrollControllerListener != null) {
      widget.scrollController.removeListener(scrollControllerListener);
    }
    _scrollControllerListener = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          child: Opacity(
            opacity: isThisStickyItemVisible ? 1.0 : 0.0,
            child: widget.item.builder(context),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.up,
            children: [
              Opacity(
                opacity: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: widget.item.builder(context),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Opacity(
                  opacity: isPreviousStickyItemVisible ? 1.0 : 0.0,
                  child: Builder(
                    key: keyForDummyPreviousStickyItem,
                    builder: (context) => widget.previousStickyItem?.builder.call(context) ?? const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}