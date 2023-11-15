
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_samples_2/linear_gradient_rotation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF424242),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
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
                  transform: LinearGradientRotation(135),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                  ),
                ),
              ),

               */

              Container(
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
                    transform: LinearGradientRotation(45),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
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
                    transform: LinearGradientRotation(135),
                  ),
                ),
              ),

              /*
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment(-1, -1),
                  end: Alignment(1, 1),
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFF00FF),
                    Color(0xFF0000FF),
                  ],
                  stops: [
                    0.0,
                    0.5,
                    1.0,
                  ],
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
               */

              /*
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment(-1, 0),
                  end: Alignment(1, 0),
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFF0000),
                    Color(0xFF0000FF),
                    Color(0xFF0000FF),
                  ],
                  stops: [
                    0.0,
                    0.49,
                    0.51,
                    1.0,
                  ],
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment(-1, 0),
                  end: Alignment(1, 0),
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFF0000),
                    Color(0xFF0000FF),
                    Color(0xFF0000FF),
                  ],
                  stops: [
                    0.0,
                    0.49,
                    0.51,
                    1.0,
                  ],
                  transform: GradientRotation(pi / 4),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
               */

              /*
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment(-1, 0),
                  end: Alignment(1, 0),
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
                    0.0,
                    0.249,
                    0.251,
                    0.499,
                    0.501,
                    0.749,
                    0.751,
                    1.0,
                  ],
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment(-1, 0),
                  end: Alignment(1, 0),
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
                    0.0,
                    0.249,
                    0.251,
                    0.499,
                    0.501,
                    0.749,
                    0.751,
                    1.0,
                  ],
                  transform: GradientRotation(pi / 4),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              */

              /*
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
                  begin: Alignment(0, 1),
                  end: Alignment(0, -1),

                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFF00FF),
                    Color(0xFF0000FF),
                  ],
                  stops: [
                    0.1774,
                    0.499,
                    0.8065,
                  ],
                  transform: GradientRotation((104.0 / 360.0) * (pi * 2)),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSans'
                  ),
                ),
              ),
              */
/*
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
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
                  // transform: MyTransform((45.0 / 360.0) * (math.pi * 2)),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSans'
                  ),
                ),
              ),

              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
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
                  transform: GradientRotation((45.0 / 360.0) * (math.pi * 2)),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'NotoSans'
                  ),
                ),
              ),

              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
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
                  transform: MyTransform((45.0 / 360.0) * (math.pi * 2)),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "ABC",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSans'
                  ),
                ),
              ),

              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
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
                  transform: MyTransform2((90.0 / 360.0) * (math.pi * 2)),
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  "888",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSans'
                  ),
                ),
              ),
              */
              _buildContainer(0, logEnabled: true),
              const SizedBox(height: 16),
              _buildContainer(10),
              const SizedBox(height: 16),
              _buildContainer(20),
              const SizedBox(height: 16),
              _buildContainer(30),
              // const SizedBox(height: 16),
              // _buildContainer(40),
              const SizedBox(height: 16),
              _buildContainer(45),
              const SizedBox(height: 16),
              _buildContainer(85),
              const SizedBox(height: 16),
              _buildContainer(90),
              const SizedBox(height: 16),
              _buildContainer(135),
              const SizedBox(height: 16),
              _buildContainer(180),
              const SizedBox(height: 16),
              _buildContainer(225),
              const SizedBox(height: 16),
              _buildContainer(270),
              const SizedBox(height: 16),
              _buildContainer(315),
              const SizedBox(height: 16),
              _buildContainer(360),
              const SizedBox(height: 16),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildContainer(double degree, { bool? logEnabled}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$degree deg',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
              begin: Alignment(0, 1),
              end: Alignment(0, -1),
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFF0000),
                Color(0xFFFF0000),
                Color(0xFFFFFF00),
                Color(0xFFFFFF00),
                Color(0xFF00FF00),
                Color(0xFF00FF00),
                Color(0xFF0000FF),
                Color(0xFF0000FF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
              stops: [
                0.00,
                0.001,
                0.001,
                0.25,
                0.25,
                0.5,
                0.5,
                0.75,
                0.75,
                0.999,
                0.999,
                1.0,
              ],
              transform: LinearGradientRotation(degree),
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Container(
              height: 50,
              width: 100,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(
          // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
          begin: Alignment(0, 1),
          end: Alignment(0, -1),


          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
            Color(0xFFFF0000),
            Color(0xFFFF0000),
            Color(0xFFFFFF00),
            Color(0xFFFFFF00),
            Color(0xFF00FF00),
            Color(0xFF00FF00),
            Color(0xFF0000FF),
            Color(0xFF0000FF),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
          stops: [
            0.00,
            0.00,
            0.01,
            0.25,
            0.25,
            0.5,
            0.5,
            0.75,
            0.75,
            0.99,
            0.99,
            1.0,
          ],
          transform: LinearGradientRotation((degree / 360.0) * (math.pi * 2)),
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Container(
          height: 50,
          width: 100,
          color: Colors.white,
        ),
      );
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // transformを適用する前の状態。これは下から上とする(CSSでいう0degreeとする)。
          begin: Alignment(0, 1),
          end: Alignment(0, -1),

          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
            Color(0xFFFF0000),
            Color(0xFFFF0000),
            Color(0xFFFFFF00),
            Color(0xFFFFFF00),
            Color(0xFF00FF00),
            Color(0xFF00FF00),
            Color(0xFF0000FF),
            Color(0xFF0000FF),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
          stops: [
            0.00,
            0.00,
            0.01,
            0.25,
            0.25,
            0.5,
            0.5,
            0.75,
            0.75,
            0.99,
            0.99,
            1.0,
          ],
          transform: LinearGradientRotation((degree / 360.0) * (math.pi * 2)),
        ),
      ),
    );
  }
}

/*
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
 */

class MyTransform extends GradientTransform {
  final double radians;
  const MyTransform(this.radians);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double sinRadians = math.sin(radians);
    final double oneMinusCosRadians = 1 - math.cos(radians);
    final Offset center = bounds.center;
    final double originX = sinRadians * center.dy + oneMinusCosRadians * center.dx;
    final double originY = -sinRadians * center.dx + oneMinusCosRadians * center.dy;
    // print('***** bounds: $bounds, center: ${bounds.center}, origin: ${originX}, ${originY}');

    return Matrix4.identity()
      ..translate(originX, originY)
    // ..translate(100.0, 100.0)
      // ..scale(2.0, 2.0)
      ..rotateZ(radians)
      // ..scale(0.5, 0.5)
      // ..rotateZ(radians)
    ;
  }
}