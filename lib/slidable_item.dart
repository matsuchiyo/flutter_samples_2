import 'package:flutter/material.dart';
import 'package:flutter_samples_2/slidable_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Test(),
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: ListTile
            .divideTiles(
          context: context,
          tiles: List.generate(42, (index) {
            return SlidableView(
              menuOptions: [
                SlidableViewMenuOption(
                  icon: Icons.delete,
                  title: 'Delete',
                  onTap: () {
                    print('***** onDelete');
                  },
                ),
                SlidableViewMenuOption(
                  icon: Icons.delete,
                  title: 'Delete',
                  onTap: () {
                    print('***** onDelete');
                  },
                ),
              ],
              child: Container(
                // height: 72,
                // child: Text("Drag me"),
                color: Colors.amberAccent,
                // height: 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Drag me"),
                    Text("hoge"),
                    Text("fuga"),
                  ],
                ),
              ),
              // child: ListTile(
              //   title: Container(
              //     // height: 72,
              //     child: Text("Drag me"),
              //     color: Colors.amberAccent,
              //   ),
              // ),
            );
            /*
            return SlideMenu(
              child: ListTile(
                title: Container(child: Text("Drag me")),
              ),
              menuItems: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => print('delete'),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () => print('info'),
                  ),
                ),
              ],
            );
             */
          }),
        )
            .toList(),
      ),
    );
  }
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  SlideMenu({required this.child, required this.menuItems});

  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(
        begin: const Offset(0.0, 0.0),
        end: const Offset(-0.2, 0.0)
    ).animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        setState(() {
          if (context.size == null || data.primaryDelta == null) return;
          _controller.value -= data.primaryDelta! / (context.size!.width / 2);
        });
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity == null) {
          print('***** primaryVelocity is null');
          return;
        }
        if (data.primaryVelocity! > 1000) {
          print('***** branch 1 primaryVelocity: ${data.primaryVelocity}');
          _controller.animateTo(
              .0); //close menu on fast swipe in the right direction
        } else if (_controller.value >= .5 || data.primaryVelocity! < -1000) { // fully open if dragged a lot to left or on fast swipe to left
          print('***** branch 2 primaryVelocity: ${data.primaryVelocity}');
          _controller.animateTo(1.0);
        } else { // close if none of above
          print('***** branch 3 primaryVelocity: ${data.primaryVelocity}');
          _controller.animateTo(.0);
        }
      },
      child: Stack(
        children: <Widget>[
          SlideTransition(position: animation, child: widget.child),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child: Container(
                            color: Colors.black26,
                            child: Row(
                              children: widget.menuItems.map((child) {
                                return Expanded(
                                  child: child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}