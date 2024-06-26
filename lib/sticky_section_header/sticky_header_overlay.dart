
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// https://stackoverflow.com/a/49650741

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'hoge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScrollController();
  OverlayEntry? sticky;
  GlobalKey stickyKey = GlobalKey();

  @override
  void initState() {
    sticky?.remove();

    sticky = OverlayEntry(
      builder: (context) => stickyBuilder(context),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (sticky != null) {
        Overlay.of(context).insert(sticky!);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    sticky?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 6) {
            return Container(
              key: stickyKey,
              height: 100.0,
              color: Colors.green,
              child: const Text("I'm fat"),
            );
          }
          return ListTile(
            title: Text(
              'Hello $index',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget stickyBuilder(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final keyContext = stickyKey.currentContext;
        if (keyContext != null) {
          // widget is visible
          final box = keyContext.findRenderObject() as RenderBox;
          final pos = box.localToGlobal(Offset.zero);
          return Positioned(
            top: pos.dy + box.size.height,
            left: 50.0,
            right: 50.0,
            height: box.size.height,
            child: Material(
              child: Container(
                alignment: Alignment.center,
                color: Colors.purple,
                child: const Text("^ Nah I think you're okay"),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}