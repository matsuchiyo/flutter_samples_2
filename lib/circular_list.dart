
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  static const _listPadding = EdgeInsets.all(16);
  static const _itemSpace = 16.0;
  static const _circularOrbitRadius = 480.0;
  static const _itemHeight = 120.0;
  static const _itemWidth = 120.0;

  late ScrollController _scrollController;
  final List<String> _items = List.generate(1000, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final scrollFrameHeight = constraints.maxHeight;
        final scrollFrameCenterY = scrollFrameHeight / 2;
        return ListView.builder(
          controller: _scrollController,
          padding: _listPadding.copyWith(
            top: _listPadding.top - _itemSpace / 2,
            bottom: _listPadding.bottom - _itemSpace / 2,
          ),
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int i) {
            final itemCenterYInScrollContent = (_listPadding.top - _itemSpace / 2)
                + (_itemSpace / 2 + _itemHeight + _itemSpace / 2) * i
                + _itemSpace / 2 + _itemHeight / 2;
            final itemCenterYInScrollFrame = itemCenterYInScrollContent - _scrollController.offset;
            final distanceBetweenItemCenterYInScrollFrameAndScrollFrameCenterY = (scrollFrameCenterY - itemCenterYInScrollFrame).abs();
            final distanceBetweenCircularOrbitCenterAndItemMaxX = sqrt(
              max(
                0, // マイナスにならないように。
                pow(_circularOrbitRadius, 2) - pow(distanceBetweenItemCenterYInScrollFrameAndScrollFrameCenterY, 2) // 三平方の定理を使っているだけ。
              )
            );
            final itemMarginRight = _circularOrbitRadius - distanceBetweenCircularOrbitCenterAndItemMaxX;

            const itemVerticalPadding = _itemSpace / 2;

            return Stack(
              key: ValueKey(i),
              children: [
                Container(
                  height: itemVerticalPadding + _itemHeight + itemVerticalPadding,
                  width: double.infinity,
                  color: Colors.blue.withOpacity(0.25),
                ),
                Positioned(
                  top: itemVerticalPadding,
                  bottom: itemVerticalPadding,
                  right: itemMarginRight,
                  child: Container(
                    color: Colors.blue,
                    alignment: Alignment.center,
                    width: _itemWidth,
                    height: _itemHeight,
                    child: Text(
                      _items[i],
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}