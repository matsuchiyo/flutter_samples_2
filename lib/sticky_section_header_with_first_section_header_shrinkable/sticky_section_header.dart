

import 'dart:math';

import 'package:flutter/cupertino.dart' hide Element;
import 'package:flutter_samples_2/sticky_section_header_with_first_section_header_shrinkable/element.dart';
import 'package:flutter_samples_2/sticky_section_header_with_first_section_header_shrinkable/item_view.dart';
import 'package:flutter_samples_2/sticky_section_header_with_first_section_header_shrinkable/section_header.dart';
import 'package:flutter_samples_2/sticky_section_header_with_first_section_header_shrinkable/sticky_item_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  List<Element> items = [];
  StickyItem? _currentStickyItem;

  @override
  initState() {
    super.initState();

    _scrollController = ScrollController();

    items = List.generate(10, (i) {
      return <Element>[
        StickyItem(builder: (context) => SectionHeader(title: 'Section Headerrr $i')),
        ...List.generate(10, (i2) => NormalItem(
          builder: (context) => ItemView(title: 'Itemmm $i $i2'),
        )),
      ];
    }).expand((e) => e).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final marginTopOfStickyItem = _SliverPersistentHeaderDelegateImpl.firstSectionHeaderMinHeight + _SliverPersistentHeaderDelegateImpl.headerMinHeight;
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverPersistentHeaderDelegateImpl(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: items.length,
                      (context, i) {
                    final item = items[i];
                    switch (item) {
                      case NormalItem(builder: final builder):
                        return builder(context);
                      case StickyItem(builder: final builder):
                        final previousStickyIndex = items.sublist(0, max(0, i - 1)).lastIndexWhere((element) => element is StickyItem);
                        return StickyItemView(
                          scrollController: _scrollController,
                          item: item,
                          previousStickyItem: previousStickyIndex == -1 ? null : (items[previousStickyIndex] as StickyItem),
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
              ),
            ],
          ),
          Positioned(
            top: marginTopOfStickyItem,
            left: 0,
            right: 0,
            child: _currentStickyItem?.builder(context) ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}



class _SliverPersistentHeaderDelegateImpl extends SliverPersistentHeaderDelegate {
  static const headerMaxHeight = 128.0;
  static const headerMinHeight = 64.0;
  static const firstSectionHeaderMaxHeight = 48.0;
  // static const firstSectionHeaderMinHeight = 24.0;
  static const firstSectionHeaderMinHeight = SectionHeader.height;

  @override
  double get maxExtent => headerMaxHeight + firstSectionHeaderMaxHeight;

  @override
  double get minExtent => headerMinHeight + firstSectionHeaderMinHeight;

  // shrinkOffset: 0 ~ maxExtentの間
  // overlapsContent: よくわからない。常にfalseだった。
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Error: SliverGeometry is not valid: The "layoutExtent" exceeds the "paintExtent".
    // https://stackoverflow.com/a/73170774/8834586
    return Align(
      alignment: Alignment.center,
      child: _build(context, shrinkOffset, overlapsContent),
    );
  }

  Widget _build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final headerHeight = max(
      headerMinHeight,
      headerMaxHeight - shrinkOffset,
    );
    final firstSectionHeaderHeight = max(
      firstSectionHeaderMinHeight,
      min(
        firstSectionHeaderMaxHeight,
        (maxExtent - shrinkOffset) - headerHeight,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: headerHeight,
          color: const Color(0x88FF0000),
        ),
        Container(
          height: firstSectionHeaderHeight,
          color: const Color(0x880000FF),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Stack(
            children: [
              const SizedBox.expand(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: (firstSectionHeaderHeight - firstSectionHeaderMinHeight) / (firstSectionHeaderMaxHeight - firstSectionHeaderMinHeight),
                  child: const Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Text(
                  'Section Header 0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant _SliverPersistentHeaderDelegateImpl oldDelegate) {
    return false; // TODO:
  }
}