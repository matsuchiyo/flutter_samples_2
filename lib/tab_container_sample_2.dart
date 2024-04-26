
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_samples_2/tab_container_sample.dart';

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
  int _selectedIndex = 2;

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
            selectedIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class TabContainer extends StatelessWidget {
  static const padding = EdgeInsets.all(2.0);
  static const height = 40.0;
  static const duration = Duration(milliseconds: 500);
  static const curve = Curves.easeInOutExpo;

  final List<String> titles;
  final int selectedIndex;
  final void Function(int index) onTap;

  const TabContainer({
    super.key,
    required this.titles,
    required this.selectedIndex,
    required this.onTap,
  });

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
                child: AnimatedSlide(
                  offset: Offset(
                    1.0 * selectedIndex,
                    0.0,
                  ),
                  duration: duration,
                  curve: curve,
                  child: Container(
                    height: maxHeight,
                    width: maxWidth / max(1, titles.length),
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
              children: titles.asMap().entries.map((entry) => Expanded(
                child: _TabContainerItem(
                  title: entry.value,
                  isSelected: entry.key == selectedIndex,
                  duration: duration,
                  curve: curve,
                  onTap: () => onTap(entry.key),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabContainerItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Duration duration;
  final Curve curve;
  final void Function() onTap;

  const _TabContainerItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.duration,
    required this.curve,
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
              child: AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: duration,
                curve: curve,
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
                child: AnimatedOpacity(
                  opacity: isSelected ? 0.0 : 1.0,
                  duration: duration,
                  curve: curve,
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
