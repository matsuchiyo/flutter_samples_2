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

  List<(String, bool)> items = List.generate(count, (i) => ('Item $i', false));

  // reference: https://api.flutter.dev/flutter/widgets/DecoratedBoxTransition-class.html
  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.zero,
      // No shadow.
    ),
    end: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66666666),
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: Offset(0, 6.0),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ReorderableList(
        itemCount: count,
        itemBuilder: (context, i) {
          final item = items[i];
          return ReorderableDragStartListener(
            key: ValueKey(item),
            index: i,
            child: ExpandableItem(
              title: item.$1,
              isInitiallyExpanded: item.$2,
              onExpandedStatusChanged: (newExpandedStatus) {
                items[i] = (item.$1, newExpandedStatus);
              },
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          print('***** onReorder $oldIndex, $newIndex');
          if (oldIndex < newIndex) {
            items = [...items]
              ..insert(newIndex, items[oldIndex])
              ..removeAt(oldIndex);
            setState(() {});
          } else if (oldIndex > newIndex) {
            items = [...items]
              ..removeAt(oldIndex)
              ..insert(newIndex, items[oldIndex]);
            setState(() {});
          }
        },
        proxyDecorator: (child, index, animation) {
          return DecoratedBoxTransition(
            decoration: decorationTween.animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}

class ExpandableItem extends StatefulWidget {
  final String title;
  final bool isInitiallyExpanded;
  final void Function(bool isExpanded) onExpandedStatusChanged;
  const ExpandableItem({
    super.key,
    required this.title,
    required this.isInitiallyExpanded,
    required this.onExpandedStatusChanged,
  });
  @override
  State<ExpandableItem> createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}