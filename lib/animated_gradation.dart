
import 'package:flutter/material.dart';
import 'package:flutter_samples_2/linear_gradient_rotation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    animationController.repeat();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          /*
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(24, (index) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildContainer(degree: 15.0 * index),
              )),
            ],
          ),
           */
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(24, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _buildAnimatedContainer(
                      degree: 15.0 * index,
                      animation: animationController.value,
                    ),
                  )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({required double degree}) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 1),
          end: Alignment(0, -1),
          colors: [
            Color(0xFFFF0000),
            Color(0xFFFF0000),
            Color(0xFFFFFF00),
            Color(0xFFFFFF00),
            Color(0xFF00FF00),
            Color(0xFF00FF00),
            Color(0xFF0000FF),
            Color(0xFF0000FF),
          ],
          stops: [
            0,
            0.25,
            0.25,
            0.5,
            0.5,
            0.75,
            0.75,
            1.0,
          ],
          transform: LinearGradientRotation(degree: degree),
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer({required double degree, required double animation}) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 1),
          end: Alignment(0, -1),
          colors: [
            Color(0xFFFF0000),
            Color(0xFFFF0000),
            Color(0xFFFFFF00),
            Color(0xFFFFFF00),
            Color(0xFF00FF00),
            Color(0xFF00FF00),
            Color(0xFF0000FF),
            Color(0xFF0000FF),
          ],
          stops: [
            0,
            0.25,
            0.25,
            0.5,
            0.5,
            0.75,
            0.75,
            1.0,
          ],
          transform: HorizontalSlidedLinearGradientRotation(degree: degree, animation: animation),
          tileMode: TileMode.mirror,
          // tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}

class HorizontalSlidedLinearGradientRotation extends LinearGradientRotation {
  final double animation;
  const HorizontalSlidedLinearGradientRotation({required super.degree, required this.animation});
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return super.transform(bounds, textDirection: textDirection)
      ?..translate(
        -(bounds.width * 2) * animation, // TileMode.mirrorなので、* 2。
        -(bounds.height * 2) * animation,
      );
  }
}