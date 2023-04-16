
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
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
  
  late final AnimationController _animationController;

  double? _dragStartX;
  double? _lastDragUpdatedX;
  bool? _isOpening;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
          child: Center(
            child: CupertinoButton(
              child: const Text('Open Drawer'),
              onPressed: () {
                _animationController.forward();
              },
            ),
          ),
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(_animationController),
          child: _DrawerPage(
            onCloseTap: () => _animationController.reverse(),
          ),
        ),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          final viewWidth = constraints.maxWidth;
          return GestureDetector(
            onHorizontalDragDown: (DragDownDetails details) {
              _clear();
            },
            onHorizontalDragStart: (DragStartDetails details) {
              _dragStartX = details.localPosition.dx;
              _isOpening = _animationController.value != 1.0;
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              final dragStartX = _dragStartX;
              final isOpening = _isOpening;
              if (dragStartX == null || isOpening == null) return;

              final newX = details.localPosition.dx;
              if (isOpening) {
                if (_lastDragUpdatedX == null && newX <= dragStartX) {
                  return;
                }
              } else {
                if (_lastDragUpdatedX == null && newX >= dragStartX) {
                  return;
                }
              }

              _lastDragUpdatedX = newX;
              _animationController.value = newX / viewWidth;
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              final dragStartX = _dragStartX;
              final lastDragUpdateX = _lastDragUpdatedX;
              if (dragStartX == null || lastDragUpdateX == null) return;
              _animationController.animateTo((lastDragUpdateX / viewWidth).round().toDouble());

              _clear();
            },
            onHorizontalDragCancel: () {
              _clear();
            },
          );
        }),
      ],
    );
  }

  void _clear() {
    _dragStartX = null;
    _lastDragUpdatedX = null;
    _isOpening = null;
  }
}

class _DrawerPage extends StatelessWidget {
  final void Function() onCloseTap;

  const _DrawerPage({
    super.key,
    required this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0x00000000),
      child: Stack(
        children: [
          Container(color: const Color(0x880000FF)),
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: CupertinoButton(
                onPressed: onCloseTap,
                child: const Text(
                  'Close',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
