
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_samples_2/sticky_header/scratch/sticky_list_view_element.dart';

class StickyListView extends StatefulWidget {
  final List<StickyListViewElement> items;
  final double marginTopOfStickyItem;

  const StickyListView({
    super.key,
    required this.items,
    required this.marginTopOfStickyItem,
  });
  @override
  State<StickyListView> createState() => _StickyListViewState();
}

class _StickyListViewState extends State<StickyListView> {

  late ScrollController _scrollController;
  late List<GlobalKey> _keys;

  StickyItem? _currentStickyItem;

  @override
  void initState() {
    _scrollController = ScrollController();
    _keys = List.generate(widget.items.length, (index) => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final marginTopOfStickyItem = widget.marginTopOfStickyItem;
    
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: marginTopOfStickyItem),
          controller: _scrollController,
          itemCount: items.length,
          itemBuilder: (context, i) {
            final item = items[i];
            switch (item) {
              case NormalItem(builder: final builder):
                return builder(context);
              case StickyItem(builder: final builder):
                final previousStickyIndex = items.sublist(0, max(0, i - 1)).lastIndexWhere((element) => element is StickyItem);
                return _StickyItemView(
                  scrollController: _scrollController,
                  item: item,
                  previousStickyItem: previousStickyIndex == -1 ? null : (items[previousStickyIndex] as StickyItem),
                  keyForDummyPreviousStickyItem: _keys[i],
                  marginTopOfStickyItem: marginTopOfStickyItem,
                  onCurrentStickyItemChanged: (stickyItem) {
                    if (stickyItem == _currentStickyItem) return;
                    setState(() {
                      _currentStickyItem = stickyItem;
                    });
                  },
                );
            }
          },
        ),
        Positioned(
          top: marginTopOfStickyItem,
          left: 0,
          right: 0,
          child: _currentStickyItem?.builder(context) ?? const SizedBox(),
        ),
      ],
    );
  }
}


class _StickyItemView extends StatefulWidget {
  final ScrollController scrollController;
  final StickyItem item;
  final StickyItem? previousStickyItem;
  final GlobalKey keyForDummyPreviousStickyItem;
  final double marginTopOfStickyItem;
  final void Function(StickyItem? stickyItem) onCurrentStickyItemChanged;

  const _StickyItemView({
    required this.scrollController,
    required this.item,
    required this.previousStickyItem,
    required this.keyForDummyPreviousStickyItem,
    required this.marginTopOfStickyItem,
    required this.onCurrentStickyItemChanged,
  });

  @override
  State<_StickyItemView> createState() => _StickyItemViewState();
}

class _StickyItemViewState extends State<_StickyItemView> {
  bool isThisStickyItemVisible = true;
  bool isPreviousStickyItemVisible = false;
  final key = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      bool isPreviousStickyItemVisibleTemp = isPreviousStickyItemVisible;
      bool isThisStickyItemVisibleTemp = isThisStickyItemVisible;

      if (widget.previousStickyItem != null) {
        final RenderBox? renderBox = widget.keyForDummyPreviousStickyItem.currentContext?.findRenderObject() as RenderBox?;
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
      }
    });
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
                    key: widget.keyForDummyPreviousStickyItem,
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
