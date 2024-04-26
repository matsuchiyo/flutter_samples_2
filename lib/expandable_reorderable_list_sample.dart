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
  static const count = 50;

  Map<int, bool> expandedStatusMap = {};

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ReorderableList(
        itemCount: count,
        itemBuilder: (context, i) => _ExpandableItem(
          key: ValueKey(i),
          index: i,
          title: 'Item $i',
          isInitiallyExpanded: expandedStatusMap[i] ?? false,
          onExpandedStatusChanged: (newExpandedStatus) {
            expandedStatusMap[i] = newExpandedStatus;
          },
        ),
        onReorder: (oldIndex, newIndex) {
          print('***** onReorder $oldIndex, $newIndex');
        },
      ),
    );
  }
}

class _ExpandableItem extends StatefulWidget {
  final int index;
  final String title;
  final bool isInitiallyExpanded;
  final void Function(bool isExpanded) onExpandedStatusChanged;
  const _ExpandableItem({
    super.key,
    required this.index,
    required this.title,
    required this.isInitiallyExpanded,
    required this.onExpandedStatusChanged,
  });
  @override
  State<_ExpandableItem> createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<_ExpandableItem> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: widget.index,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.title),
              ),
              CupertinoButton(
                child: const Icon(CupertinoIcons.add),
                onPressed: () {
                  final newExpandedStatus = !isExpanded;
                  setState(() {
                    isExpanded = newExpandedStatus;
                  });
                  widget.onExpandedStatusChanged(newExpandedStatus);
                },
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutExpo,
            child: Container(
              color: const Color(0xFF0000FF),
              height: isExpanded ? 120.0 : 0.0,
            ),
          ),
          // Container(
          //   color: const Color(0xFF0000FF),
          //   height: isExpanded ? 120.0 : 0.0,
          // ),
        ],
      ),
    );
  }
}