
import 'package:flutter/cupertino.dart';
import 'package:flutter_samples_2/sticky_header/scratch/sticky_list_view.dart';
import 'package:flutter_samples_2/sticky_header/scratch/sticky_list_view_element.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: MyHomePage(title: 'hoge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('hoge'),
      ),
      /*
      child: SectionListView(
        sectionCount: 10,
        countOfItemInSection: (section) => 10,
        sectionHeaderBuilder: (context, section) => Text('Section Header $section'),
        itemBuilder: (context, section, i) => Text('Item $section-$i'),
      )
       */
      child: StickyListView(
        marginTopOfStickyItem: 120,
        items: List.generate(10, (i) => [
          StickyItem(
            builder: (context) {
              return _SectionHeader(
                key: ValueKey('section_header_$i'),
                'Section Header $i',
              );
            },
          ),
          ...List.generate(10, (i2) => [
            NormalItem(
              builder: (context) {
                return _ItemView(
                  key: ValueKey('item_${i}_$i2'),
                  'Item $i-$i2',
                );
              },
            )
          ]).expand((e) => e).toList(),
        ]).expand((e) => e).toList(),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title, { super.key });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: const Color(0x88888888),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}



class _ItemView extends StatelessWidget {
  final String title;
  const _ItemView(this.title, { super.key });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      color: const Color(0xFFFFFFFF),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF444444),
        ),
      ),
    );
  }
}

@Deprecated('一番下に読み込み中の表示をしたり、ページングのエラーを出したりすることができないので非推奨。')
class SectionListView extends StatelessWidget {
  final int sectionCount;
  final int Function(int section) countOfItemInSection;
  final Widget Function(BuildContext context, int section) sectionHeaderBuilder;
  final Widget Function(BuildContext context, int section, int index) itemBuilder;

  int _globalCount = 0;
  final Map<(int section, int i), int> _sectionIndexAndItemIndexToGlobalIndex = <(int section, int i), int>{};
  final Map<int, (int section, int i)> _globalIndexToSectionIndexAndItemIndex = <int, (int section, int i)>{};

  SectionListView({
    super.key,
    required this.sectionCount,
    required this.countOfItemInSection,
    required this.sectionHeaderBuilder,
    required this.itemBuilder,
  }) {
    for (int section = 0; section < sectionCount; section++) {
      _sectionIndexAndItemIndexToGlobalIndex[(section, -1)] = _globalCount;
      _globalIndexToSectionIndexAndItemIndex[_globalCount] = (section, -1);
      _globalCount++;

      final countOfItem = countOfItemInSection(section);
      for (int itemIndex = 0; itemIndex < countOfItem; itemIndex++) {
        _sectionIndexAndItemIndexToGlobalIndex[(section, itemIndex)] = _globalCount;
        _globalIndexToSectionIndexAndItemIndex[_globalCount] = (section, itemIndex);
        _globalCount++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _globalCount,
      itemBuilder: (context, i) {
        final (section, itemIndex) = _globalIndexToSectionIndexAndItemIndex[i]!;
        final isSectionHeader = itemIndex == -1;
        if (isSectionHeader) {
          return sectionHeaderBuilder(context, section);
        } else {
          return itemBuilder(context, section, itemIndex);
        }
      },
    );
  }
}