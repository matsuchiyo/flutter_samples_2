

import 'dart:math';

import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Number Formatter',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final animationController;
  @override
  initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
      ),
      child: Center(
        child: GradatedWipe(
          animation: animationController,
          child: Image.asset(
            "assets/IMG_3198.jpg",
            width: 240,
            height: 240,
          ),
        ),
      ),
    );
  }
}

class GradatedWipe extends StatelessWidget {
  static const distanceBetweenGradationStartAndEndInRate = 0.1;
  final Animation<double> animation;
  final Widget child;
  const GradatedWipe({
    super.key,
    required this.animation,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Color(0x00000000),
            Color(0x00000000),
            Color(0xFF000000),
            Color(0xFF000000),
          ],
          stops: [
            0.0,
            min(1.0, max(0.0, (1.0 - (animation.value * (1.0 + distanceBetweenGradationStartAndEndInRate))))),
            min(1.0, max(0.0, (1.0 - (animation.value * (1.0 + distanceBetweenGradationStartAndEndInRate))  + distanceBetweenGradationStartAndEndInRate))),
            1.0,
          ],
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: child,
      ),
    );
  }
}