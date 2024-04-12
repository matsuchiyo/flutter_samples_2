

import 'dart:math';

import 'package:flutter/cupertino.dart';

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
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverPersistentHeaderDelegateImpl(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 50,
              (context, i) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Text('Item $i'),
                );
              },
            )
          ),
        ]
      ),
    );
  }
}

class _SliverPersistentHeaderDelegateImpl extends SliverPersistentHeaderDelegate {
  static const headerMaxHeight = 128.0;
  static const headerMinHeight = 64.0;
  static const firstSectionHeaderMaxHeight = 48.0;
  static const firstSectionHeaderMinHeight = 24.0;

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
    print('***** _SliverPersistentHeaderDelegateImpl shrinkOffset: $shrinkOffset, overlapsContent: $overlapsContent');
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
    print('******* headerHeight: $headerHeight, firstSectionHeaderHeight: $firstSectionHeaderHeight');
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