import 'package:flutter/cupertino.dart';
import 'package:flutter_samples_2/expandable_reorderable_list_sample.dart';

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
      child: CustomScrollView(
        slivers: [
          SliverReorderableList(
            itemCount: items.length,
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
        ],
      ),
    );
  }
}