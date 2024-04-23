
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

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
  final controller = TabContainerController(initialSelectedIndex: 2);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topCenter,
          child: TabContainer(
            titles: [
              'Tab1',
              'Tab2',
              'Tab3',
            ],
            controller: controller,
            onTap: (index) {
              controller.setSelectedIndex(index);
            },
          ),
        ),
      ),
    );
  }
}

class TabContainer extends StatefulWidget {
  final List<String> titles;
  final void Function(int index) onTap;
  final TabContainerController controller;
  const TabContainer({
    super.key,
    required this.titles,
    required this.onTap,
    required this.controller,
  });
  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> with TickerProviderStateMixin {
  static const padding = EdgeInsets.all(2.0);
  static const height = 40.0;
  static const duration = Duration(milliseconds: 1000);
  static const curve = Curves.easeInOutExpo;

  late final AnimationController markerAnimationController;
  late final List<AnimationController> tabSelectionAnimationControllers;

  @override
  void initState() {
    markerAnimationController = AnimationController(vsync: this);
    tabSelectionAnimationControllers = List.generate(widget.titles.length, (_) => AnimationController(vsync: this)).toList();

    widget.controller.onSelectedIndexUpdated = (selectedIndex) {
      _animateTo(selectedIndex: selectedIndex);
    };

    final initialSelectedIndex = widget.controller.initialSelectedIndex ?? 0;
    _setInitialAnimationValue(initialSelectedIndex: initialSelectedIndex);

    super.initState();
  }

  void _animateTo({ required int selectedIndex }) {
    if (selectedIndex < 0 || selectedIndex >= widget.titles.length) return;

    markerAnimationController.animateTo(
      selectedIndex.toDouble() / max(1, widget.titles.length - 1),
      duration: duration,
      curve: curve,
    );

    tabSelectionAnimationControllers.asMap().forEach((i, controller) {
      controller.animateTo(
        i == selectedIndex ? 1.0 : 0.0,
        duration: duration,
        curve: curve,
      );
    });
  }

  void _setInitialAnimationValue({ required int initialSelectedIndex }) {
    final modifiedInitialSelectedIndex = max(0, min(widget.titles.length - 1, initialSelectedIndex));
    markerAnimationController.value = modifiedInitialSelectedIndex.toDouble() / max(1, widget.titles.length - 1);
    tabSelectionAnimationControllers.asMap().forEach((i, controller) {
      controller.value = i == modifiedInitialSelectedIndex ? 1.0 : 0.0;
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    markerAnimationController.dispose();
    for (var controller in tabSelectionAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xFFAAAAAA),
        borderRadius: BorderRadius.all(Radius.circular(height / 2)),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraint) {
              final maxWidth = constraint.maxWidth;
              final maxHeight = constraint.maxHeight;
              return Align(
                alignment: Alignment.centerLeft,
                child: SlideTransition(
                  position: Tween(
                    begin: Offset.zero,
                    end: Offset(
                      max(0.0, widget.titles.length - 1.0),
                      0.0,
                    )
                  ).animate(markerAnimationController),
                  child: Container(
                    height: maxHeight,
                    width: maxWidth / max(1, widget.titles.length),
                    decoration: BoxDecoration(
                      color: const Color(0xff000000),
                      borderRadius: BorderRadius.all(Radius.circular(maxHeight / 2)),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.titles.asMap().entries.map((entry) => Expanded(
                child: _TabContainerItem(
                  title: entry.value,
                  selectionAnimation: tabSelectionAnimationControllers[entry.key],
                  onTap: () => widget.onTap(entry.key),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TabContainerController {
  final int? initialSelectedIndex;
  void Function(int selectedIndex)? onSelectedIndexUpdated;

  TabContainerController({
    this.initialSelectedIndex,
  });

  void setSelectedIndex(int index) {
    onSelectedIndexUpdated?.call(index);
  }

  void dispose() {
    onSelectedIndexUpdated = null;
  }
}

class _TabContainerItem extends StatelessWidget {
  final String title;
  final Animation<double> selectionAnimation;
  final void Function() onTap;
  const _TabContainerItem({
    super.key,
    required this.title,
    required this.selectionAnimation,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: selectionAnimation,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: FadeTransition(
                  opacity: Tween(begin: 1.0, end: 0.0).animate(selectionAnimation),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
