import 'package:flutter/cupertino.dart';

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
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('hoge'),
      // ),
      child: CustomScrollView(
        slivers: List.generate(10, (index) => <Widget>[
          // SliverAppBar(
          //   title: Text('title $index'),
          // ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SliverPersistentHeaderDelegateImpl('title: $index'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index2) => Container(
                padding: const EdgeInsets.all(16),
                child: Text('Item $index-$index2'),
              ),
            ),
          ),
        ]).expand((element) => element).toList(),
      ),
    );
  }
}

class _SliverPersistentHeaderDelegateImpl extends SliverPersistentHeaderDelegate {
  final String title;
  _SliverPersistentHeaderDelegateImpl(this.title);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    print('***** build title: $title, shrinkOffset: $shrinkOffset, overlapsContent: $overlapsContent');
    return Container(
      color: const Color(0xFF0000FF),
      padding: const EdgeInsets.all(16),
      child: Text(title),
    );
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant _SliverPersistentHeaderDelegateImpl oldDelegate) {
    return oldDelegate.title != title;
  }
}